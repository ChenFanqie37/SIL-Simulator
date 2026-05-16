import requests
import json
import time
import sys
import os

KEYS_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "apikey.txt")

def load_keys():
    keys = []
    if os.path.exists(KEYS_FILE):
        with open(KEYS_FILE, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line and line.startswith('AIzaSy'):
                    keys.append(line)
    return keys

CHANNELS = ["chat", "weverse", "naver", "company", "dispatch", "event", "date", "translate"]
BASE_URL = "https://generativelanguage.googleapis.com/v1beta/models"

def test_keys(keys):
    print("=" * 55)
    print("  韩娱嫂嫂模拟器 - API 连接测试")
    print("=" * 55)
    print()

    if not keys:
        print("❌ 没有找到API Key！")
        print(f"   请在 {KEYS_FILE} 中添加Key，每行一个")
        return

    print(f"📋 找到 {len(keys)} 个Key\n")

    results = []
    for i, key in enumerate(keys):
        channel = CHANNELS[i] if i < len(CHANNELS) else f"extra-{i}"
        url = f"{BASE_URL}/gemini-flash-latest:generateContent?key={key}"
        payload = {"contents": [{"parts": [{"text": "请用一句话回复：你好"}]}]}

        print(f"🔑 Key {i+1} ({channel})")
        print(f"   {key[:20]}...{key[-8:]}")

        try:
            start = time.time()
            resp = requests.post(url, json=payload, timeout=30)
            elapsed = time.time() - start

            if resp.status_code == 200:
                data = resp.json()
                text = ""
                try:
                    text = data["candidates"][0]["content"]["parts"][0]["text"]
                except:
                    text = "(解析异常)"
                print(f"   ✅ 正常 ({elapsed:.1f}s) - {text.strip()[:40]}")
                results.append(True)
            elif resp.status_code == 429:
                print(f"   ⚠️  429 限流 (Key有效，请求太快)")
                results.append(True)
            elif resp.status_code == 403:
                print(f"   ❌ 403 无权限 (Key无效或已过期)")
                results.append(False)
            else:
                print(f"   ❌ HTTP {resp.status_code}")
                results.append(False)

        except requests.exceptions.ConnectionError:
            print(f"   ❌ 网络连接失败 (无法访问Google)")
            results.append(False)
        except requests.exceptions.Timeout:
            print(f"   ❌ 请求超时")
            results.append(False)
        except Exception as e:
            print(f"   ❌ 异常: {e}")
            results.append(False)

        time.sleep(1)

    print()
    print("=" * 55)
    ok = sum(results)
    total = len(results)
    if ok == total:
        print(f"  ✅ 全部 {total} 个Key正常！")
    elif ok > 0:
        print(f"  ⚠️  {ok}/{total} 个Key正常，{total-ok} 个失败")
    else:
        print(f"  ❌ 全部 {total} 个Key失败！")
        print()
        print("  排查建议:")
        print("  1. 检查网络是否能访问Google")
        print("  2. 如果在国内，需要开启代理/VPN")
        print("  3. 访问 https://aistudio.google.com/ 检查Key状态")
    print("=" * 55)

if __name__ == "__main__":
    keys = load_keys()
    test_keys(keys)

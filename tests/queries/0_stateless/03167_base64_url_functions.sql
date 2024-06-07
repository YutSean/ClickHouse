SELECT base64UrlEncode(); -- { serverError NUMBER_OF_ARGUMENTS_DOESNT_MATCH }
SELECT base64UrlDecode(); -- { serverError NUMBER_OF_ARGUMENTS_DOESNT_MATCH }
SELECT base64UrlEncode('foo', 'excess argument'); -- { serverError NUMBER_OF_ARGUMENTS_DOESNT_MATCH }
SELECT base64UrlDecode('foo', 'excess argument'); -- { serverError NUMBER_OF_ARGUMENTS_DOESNT_MATCH }

-- test with valid inputs
SELECT base64UrlEncode('https://clickhouse.com');
SELECT base64UrlDecode('aHR0cHM6Ly9jbGlja2hvdXNlLmNvbQ');
-- encoding differs from base64Encode
SELECT base64UrlEncode('12?');
SELECT base64UrlDecode('MTI_');
-- long string
SELECT base64UrlEncode('https://www.google.com/search?q=clickhouse+base64+decode&sca_esv=739f8bb380e4c7ed&ei=TfRiZqCDIrmnwPAP2KLRkA8&ved=0ahUKEwjg3ZHitsmGAxW5ExAIHVhRFPIQ4dUDCBA&uact=5&oq=clickhouse+base64+decode&gs_lp=Egxnd3Mtd2l6LXNlcnAiGGNsaWNraG91c2UgYmFzZTY0IGRlY29kZTIKEAAYsAMY1gQYRzIKEAAYsAMY1gQYRzIKEAAYsAMY1gQYRzIKEAAYsAMY1gQYRzIKEAAYsAMY1gQYRzIKEAAYsAMY1gQYRzIKEAAYsAMY1gQYRzIKEAAYsAMY1gQYR0jXBFAAWABwAXgBkAEAmAEAoAEAqgEAuAEDyAEAmAIBoAIHmAMAiAYBkAYIkgcBMaAHAA&sclient=gws-wiz-serp');
SELECT base64UrlDecode('aHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS9zZWFyY2g_cT1jbGlja2hvdXNlK2Jhc2U2NCtkZWNvZGUmc2NhX2Vzdj03MzlmOGJiMzgwZTRjN2VkJmVpPVRmUmlacUNESXJtbndQQVAyS0xSa0E4JnZlZD0wYWhVS0V3amczWkhpdHNtR0F4VzVFeEFJSFZoUkZQSVE0ZFVEQ0JBJnVhY3Q9NSZvcT1jbGlja2hvdXNlK2Jhc2U2NCtkZWNvZGUmZ3NfbHA9RWd4bmQzTXRkMmw2TFhObGNuQWlHR05zYVdOcmFHOTFjMlVnWW1GelpUWTBJR1JsWTI5a1pUSUtFQUFZc0FNWTFnUVlSeklLRUFBWXNBTVkxZ1FZUnpJS0VBQVlzQU1ZMWdRWVJ6SUtFQUFZc0FNWTFnUVlSeklLRUFBWXNBTVkxZ1FZUnpJS0VBQVlzQU1ZMWdRWVJ6SUtFQUFZc0FNWTFnUVlSeklLRUFBWXNBTVkxZ1FZUjBqWEJGQUFXQUJ3QVhnQmtBRUFtQUVBb0FFQXFnRUF1QUVEeUFFQW1BSUJvQUlIbUFNQWlBWUJrQVlJa2djQk1hQUhBQSZzY2xpZW50PWd3cy13aXotc2VycA');
-- no padding
SELECT base64UrlDecode('aHR0cHM6Ly9jbGlj');
-- one-byte padding
SELECT base64UrlDecode('aHR0cHM6Ly9jbGlja2g');
-- two-bytes padding
SELECT base64UrlDecode('aHR0cHM6Ly9jbGljaw');

-- invalid inputs
SELECT base64UrlDecode('https://clickhouse.com'); -- { serverError INCORRECT_DATA }
SELECT base64UrlDecode('12?'); -- { serverError INCORRECT_DATA }

-- test FixedString argument
SELECT base64UrlEncode(toFixedString('https://clickhouse.com', 22));
SELECT base64UrlDecode(toFixedString('aHR0cHM6Ly9jbGlja2hvdXNlLmNvbQ', 30));

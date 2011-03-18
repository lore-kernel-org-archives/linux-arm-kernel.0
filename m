From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 18 Mar 2011 10:01:11 +0200
Subject: [PATCH] hwspinlock: depend on OMAP4
Message-ID: <mailman.175.1300435625.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently only OMAP4 supports hwspinlocks, so don't bother asking
anyone else.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/hwspinlock/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index eb4af28..1f29bab 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -4,6 +4,7 @@

 config HWSPINLOCK
 	tristate "Generic Hardware Spinlock framework"
+	depends on ARCH_OMAP4
 	help
 	  Say y here to support the generic hardware spinlock framework.
 	  You only need to enable this if you have hardware spinlock module
-- 
1.7.1

--0016e6d2722740c2ce049ebd4387
Content-Type: text/x-patch; charset=US-ASCII; name="0001-hwspinlock-depend-on-OMAP4.patch"
Content-Disposition: attachment; 
	filename="0001-hwspinlock-depend-on-OMAP4.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gletqugf0

RnJvbSBkMDg2ZThmOTk0YjkyNzJmOGM5OTlhZjBhNGQzMmQ4NzA3NDljNzdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPaGFkIEJlbi1Db2hlbiA8b2hhZEB3aXplcnkuY29tPgpEYXRl
OiBGcmksIDE4IE1hciAyMDExIDEwOjAxOjExICswMjAwClN1YmplY3Q6IFtQQVRDSF0gaHdzcGlu
bG9jazogZGVwZW5kIG9uIE9NQVA0CgpDdXJyZW50bHkgb25seSBPTUFQNCBzdXBwb3J0cyBod3Nw
aW5sb2Nrcywgc28gZG9uJ3QgYm90aGVyIGFza2luZwphbnlvbmUgZWxzZS4KClNpZ25lZC1vZmYt
Ynk6IE9oYWQgQmVuLUNvaGVuIDxvaGFkQHdpemVyeS5jb20+Ci0tLQogZHJpdmVycy9od3NwaW5s
b2NrL0tjb25maWcgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdzcGlubG9jay9LY29uZmlnIGIv
ZHJpdmVycy9od3NwaW5sb2NrL0tjb25maWcKaW5kZXggZWI0YWYyOC4uMWYyOWJhYiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9od3NwaW5sb2NrL0tjb25maWcKKysrIGIvZHJpdmVycy9od3NwaW5sb2Nr
L0tjb25maWcKQEAgLTQsNiArNCw3IEBACiAKIGNvbmZpZyBIV1NQSU5MT0NLCiAJdHJpc3RhdGUg
IkdlbmVyaWMgSGFyZHdhcmUgU3BpbmxvY2sgZnJhbWV3b3JrIgorCWRlcGVuZHMgb24gQVJDSF9P
TUFQNAogCWhlbHAKIAkgIFNheSB5IGhlcmUgdG8gc3VwcG9ydCB0aGUgZ2VuZXJpYyBoYXJkd2Fy
ZSBzcGlubG9jayBmcmFtZXdvcmsuCiAJICBZb3Ugb25seSBuZWVkIHRvIGVuYWJsZSB0aGlzIGlm
IHlvdSBoYXZlIGhhcmR3YXJlIHNwaW5sb2NrIG1vZHVsZQotLSAKMS43LjEKCg==
--0016e6d2722740c2ce049ebd4387--

From: prakity@marvell.com (Philip Rakity)
Date: Tue, 21 Dec 2010 21:14:34 -0800
Subject: [PATCH] mach-mmp: brownstone -- change SD/MMC clk_delay to max for=
 eMMC
Message-ID: <mailman.89.1293002155.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_delay 31 needed to support Dual Data Rate eMMC

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.=
c
index e4e458c..52fc9c5 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -157,7 +157,7 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1=
 =3D {
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 =3D {
 	.adjust_clocks	=3D 1,
 	.clk_select	=3D 1,
-	.clk_delay	=3D 15,
+	.clk_delay	=3D 31,
 	.flags		=3D PXA_FLAG_CARD_PERMANENT |
 				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
 };
--=20
1.6.0.4

--_002_92E97B42FC3E4ECAABCD214F0DB7182Cmarvellcom_
Content-Type: application/octet-stream;
	name="0023-mach-mmp-brownstone-change-SD-MMC-clk_delay-to-m.patch"
Content-Description: 0023-mach-mmp-brownstone-change-SD-MMC-clk_delay-to-m.patch
Content-Disposition: attachment;
	filename="0023-mach-mmp-brownstone-change-SD-MMC-clk_delay-to-m.patch";
	size=926; creation-date="Tue, 21 Dec 2010 23:11:35 GMT";
	modification-date="Tue, 21 Dec 2010 23:11:35 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlN2MxOTVlNTJkYWNmM2ExZDk3NmNkZDJkYTA3MzA5ZjM1NzQ2YWYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBUdWUsIDIxIERlYyAyMDEwIDIxOjE0OjM0IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gbWFj
aC1tbXA6IGJyb3duc3RvbmUgLS0gY2hhbmdlIFNEL01NQyBjbGtfZGVsYXkgdG8gbWF4IGZvciBl
TU1DCgpjbGtfZGVsYXkgMzEgbmVlZGVkIHRvIHN1cHBvcnQgRHVhbCBEYXRhIFJhdGUgZU1NQwoK
U2lnbmVkLW9mZi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KLS0tCiBh
cmNoL2FybS9tYWNoLW1tcC9icm93bnN0b25lLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLW1tcC9icm93bnN0b25lLmMgYi9hcmNoL2FybS9tYWNoLW1tcC9icm93bnN0b25lLmMKaW5k
ZXggZTRlNDU4Yy4uNTJmYzljNSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvYnJvd25z
dG9uZS5jCisrKyBiL2FyY2gvYXJtL21hY2gtbW1wL2Jyb3duc3RvbmUuYwpAQCAtMTU3LDcgKzE1
Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhIG1tcDJfc2RoX3BsYXRkYXRh
X21tYzEgPSB7CiBzdGF0aWMgc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSBtbXAyX3NkaF9wbGF0
ZGF0YV9tbWMyID0gewogCS5hZGp1c3RfY2xvY2tzCT0gMSwKIAkuY2xrX3NlbGVjdAk9IDEsCi0J
LmNsa19kZWxheQk9IDE1LAorCS5jbGtfZGVsYXkJPSAzMSwKIAkuZmxhZ3MJCT0gUFhBX0ZMQUdf
Q0FSRF9QRVJNQU5FTlQgfAogCQkJCVBYQV9GTEFHX1NEXzhfQklUX0NBUEFCTEVfU0xPVCwKIH07
Ci0tIAoxLjYuMC40Cgo=

--_002_92E97B42FC3E4ECAABCD214F0DB7182Cmarvellcom_--

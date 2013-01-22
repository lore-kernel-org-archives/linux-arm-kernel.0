From: Barry.Song@csr.com (Barry Song)
Date: Tue, 22 Jan 2013 20:22:07 +0800
Subject: [PATCH v3 6/9] ARM: PRIMA2: rtciobg: it is also compatible with marco
In-Reply-To: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
References: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1358857330-10101-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/rtciobrg.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index 9d80f1e..fc6c4ab 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -104,6 +104,7 @@ EXPORT_SYMBOL_GPL(sirfsoc_rtc_iobrg_writel);
 
 static const struct of_device_id rtciobrg_ids[] = {
 	{ .compatible = "sirf,prima2-rtciobg" },
+	{ .compatible = "sirf,marco-rtciobg" },
 	{}
 };
 
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

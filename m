From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:36 +0800
Subject: [PATCH 7/9] arm/dts: makefile: build atlas6-evb.dtb for ARCH_ATLAS6
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-8-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makefile missed to include atlas6-evb.dtb for ARCH_ATLAS6.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cc0f1fb..1b8bcd6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -41,6 +41,8 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d33ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
 
+dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
+
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb \
 	bcm28155-ap.dtb
-- 
1.8.2.3

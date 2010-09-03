From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  3 Sep 2010 20:48:46 +0200
Subject: [PATCH 7/7 v2] ARM: removed unused zreladdr specifications in all
	Makefile.boot files
In-Reply-To: <AANLkTinHVwwa3Pb8Md0W5JWOZj3U4dC66Dag_ODPwFPt@mail.gmail.com>
References: <AANLkTinHVwwa3Pb8Md0W5JWOZj3U4dC66Dag_ODPwFPt@mail.gmail.com>
Message-ID: <1283539726-26340-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

compared to v1 I now deleted

	arch/arm/mach-aaec2000/Makefile.boot
	arch/arm/mach-mmp/Makefile.boot 
	arch/arm/mach-netx/Makefile.boot
	arch/arm/mach-pxa/Makefile.boot

(found by grep -L '[^=]' arch/arm/mach-*/Makefile.boot)
and removed an (now) empty if from

	arch/arm/mach-sa1100/Makefile.boot

(and a trailing empty line)

Thanks
Uwe

 arch/arm/mach-aaec2000/Makefile.boot   |    1 -
 arch/arm/mach-at91/Makefile.boot       |    3 ---
 arch/arm/mach-clps711x/Makefile.boot   |    1 -
 arch/arm/mach-cns3xxx/Makefile.boot    |    1 -
 arch/arm/mach-davinci/Makefile.boot    |    2 --
 arch/arm/mach-dove/Makefile.boot       |    1 -
 arch/arm/mach-ebsa110/Makefile.boot    |    1 -
 arch/arm/mach-ep93xx/Makefile.boot     |    5 -----
 arch/arm/mach-footbridge/Makefile.boot |    1 -
 arch/arm/mach-gemini/Makefile.boot     |    2 --
 arch/arm/mach-imx/Makefile.boot        |    3 ---
 arch/arm/mach-integrator/Makefile.boot |    1 -
 arch/arm/mach-iop13xx/Makefile.boot    |    1 -
 arch/arm/mach-iop32x/Makefile.boot     |    1 -
 arch/arm/mach-iop33x/Makefile.boot     |    1 -
 arch/arm/mach-ixp2000/Makefile.boot    |    1 -
 arch/arm/mach-ixp23xx/Makefile.boot    |    1 -
 arch/arm/mach-ixp4xx/Makefile.boot     |    1 -
 arch/arm/mach-kirkwood/Makefile.boot   |    1 -
 arch/arm/mach-ks8695/Makefile.boot     |    1 -
 arch/arm/mach-lh7a40x/Makefile.boot    |    1 -
 arch/arm/mach-loki/Makefile.boot       |    1 -
 arch/arm/mach-mmp/Makefile.boot        |    1 -
 arch/arm/mach-msm/Makefile.boot        |    1 -
 arch/arm/mach-mv78xx0/Makefile.boot    |    1 -
 arch/arm/mach-mx25/Makefile.boot       |    1 -
 arch/arm/mach-mx3/Makefile.boot        |    1 -
 arch/arm/mach-mx5/Makefile.boot        |    1 -
 arch/arm/mach-mxc91231/Makefile.boot   |    1 -
 arch/arm/mach-netx/Makefile.boot       |    2 --
 arch/arm/mach-nomadik/Makefile.boot    |    1 -
 arch/arm/mach-ns9xxx/Makefile.boot     |    1 -
 arch/arm/mach-nuc93x/Makefile.boot     |    1 -
 arch/arm/mach-omap1/Makefile.boot      |    1 -
 arch/arm/mach-omap2/Makefile.boot      |    1 -
 arch/arm/mach-orion5x/Makefile.boot    |    1 -
 arch/arm/mach-pnx4008/Makefile.boot    |    1 -
 arch/arm/mach-pxa/Makefile.boot        |    2 --
 arch/arm/mach-realview/Makefile.boot   |    2 --
 arch/arm/mach-rpc/Makefile.boot        |    1 -
 arch/arm/mach-s3c2410/Makefile.boot    |    2 --
 arch/arm/mach-s3c64xx/Makefile.boot    |    1 -
 arch/arm/mach-s5p6440/Makefile.boot    |    1 -
 arch/arm/mach-s5p6442/Makefile.boot    |    1 -
 arch/arm/mach-s5pc100/Makefile.boot    |    1 -
 arch/arm/mach-s5pv210/Makefile.boot    |    1 -
 arch/arm/mach-s5pv310/Makefile.boot    |    1 -
 arch/arm/mach-sa1100/Makefile.boot     |    5 -----
 arch/arm/mach-shark/Makefile.boot      |    2 --
 arch/arm/mach-spear3xx/Makefile.boot   |    1 -
 arch/arm/mach-spear6xx/Makefile.boot   |    1 -
 arch/arm/mach-stmp378x/Makefile.boot   |    1 -
 arch/arm/mach-stmp37xx/Makefile.boot   |    1 -
 arch/arm/mach-u300/Makefile.boot       |    2 --
 arch/arm/mach-ux500/Makefile.boot      |    1 -
 arch/arm/mach-versatile/Makefile.boot  |    1 -
 arch/arm/mach-vexpress/Makefile.boot   |    1 -
 arch/arm/mach-w90x900/Makefile.boot    |    1 -
 58 files changed, 0 insertions(+), 78 deletions(-)
 delete mode 100644 arch/arm/mach-aaec2000/Makefile.boot
 delete mode 100644 arch/arm/mach-mmp/Makefile.boot
 delete mode 100644 arch/arm/mach-netx/Makefile.boot
 delete mode 100644 arch/arm/mach-pxa/Makefile.boot
 delete mode 100644 arch/arm/mach-shark/Makefile.boot

diff --git a/arch/arm/mach-aaec2000/Makefile.boot b/arch/arm/mach-aaec2000/Makefile.boot
deleted file mode 100644
index 8f5a8b7..0000000
--- a/arch/arm/mach-aaec2000/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-	zreladdr-y := 0xf0008000
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 3462b81..9d7c05c 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -4,15 +4,12 @@
 #   INITRD_PHYS must be in RAM
 
 ifeq ($(CONFIG_ARCH_AT91CAP9),y)
-   zreladdr-y	:= 0x70008000
 params_phys-y	:= 0x70000100
 initrd_phys-y	:= 0x70410000
 else ifeq ($(CONFIG_ARCH_AT91SAM9G45),y)
-   zreladdr-y	:= 0x70008000
 params_phys-y	:= 0x70000100
 initrd_phys-y	:= 0x70410000
 else
-   zreladdr-y	:= 0x20008000
 params_phys-y	:= 0x20000100
 initrd_phys-y	:= 0x20410000
 endif
diff --git a/arch/arm/mach-clps711x/Makefile.boot b/arch/arm/mach-clps711x/Makefile.boot
index a51fcef..eba77d3 100644
--- a/arch/arm/mach-clps711x/Makefile.boot
+++ b/arch/arm/mach-clps711x/Makefile.boot
@@ -1,5 +1,4 @@
 # The standard locations for stuff on CLPS711x type processors
-   zreladdr-y				:= 0xc0028000
 params_phys-y				:= 0xc0000100
 # Should probably have some agreement on these...
 initrd_phys-$(CONFIG_ARCH_P720T)	:= 0xc0400000
diff --git a/arch/arm/mach-cns3xxx/Makefile.boot b/arch/arm/mach-cns3xxx/Makefile.boot
index 7770128..6ac39ff 100644
--- a/arch/arm/mach-cns3xxx/Makefile.boot
+++ b/arch/arm/mach-cns3xxx/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00C00000
diff --git a/arch/arm/mach-davinci/Makefile.boot b/arch/arm/mach-davinci/Makefile.boot
index db97ef2..8cdb5ac 100644
--- a/arch/arm/mach-davinci/Makefile.boot
+++ b/arch/arm/mach-davinci/Makefile.boot
@@ -2,12 +2,10 @@ ifeq ($(CONFIG_ARCH_DAVINCI_DA8XX),y)
 ifeq ($(CONFIG_ARCH_DAVINCI_DMx),y)
 $(error Cannot enable DaVinci and DA8XX platforms concurrently)
 else
-   zreladdr-y	:= 0xc0008000
 params_phys-y	:= 0xc0000100
 initrd_phys-y	:= 0xc0800000
 endif
 else
-   zreladdr-y	:= 0x80008000
 params_phys-y	:= 0x80000100
 initrd_phys-y	:= 0x80800000
 endif
diff --git a/arch/arm/mach-dove/Makefile.boot b/arch/arm/mach-dove/Makefile.boot
index 67039c3..80f4945 100644
--- a/arch/arm/mach-dove/Makefile.boot
+++ b/arch/arm/mach-dove/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-ebsa110/Makefile.boot b/arch/arm/mach-ebsa110/Makefile.boot
index 2321260..cb7c513 100644
--- a/arch/arm/mach-ebsa110/Makefile.boot
+++ b/arch/arm/mach-ebsa110/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000400
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-ep93xx/Makefile.boot b/arch/arm/mach-ep93xx/Makefile.boot
index 0ad33f1..fcffffa 100644
--- a/arch/arm/mach-ep93xx/Makefile.boot
+++ b/arch/arm/mach-ep93xx/Makefile.boot
@@ -1,14 +1,9 @@
-   zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00008000
 params_phys-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00000100
 
-   zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0008000
 params_phys-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0000100
 
-   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0008000
 params_phys-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0000100
 
-   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0008000
 params_phys-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0000100
 
-   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0008000
 params_phys-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0000100
diff --git a/arch/arm/mach-footbridge/Makefile.boot b/arch/arm/mach-footbridge/Makefile.boot
index c7e75ac..ee22553 100644
--- a/arch/arm/mach-footbridge/Makefile.boot
+++ b/arch/arm/mach-footbridge/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-gemini/Makefile.boot b/arch/arm/mach-gemini/Makefile.boot
index 22a52c2..88f25e9 100644
--- a/arch/arm/mach-gemini/Makefile.boot
+++ b/arch/arm/mach-gemini/Makefile.boot
@@ -1,9 +1,7 @@
 ifeq ($(CONFIG_GEMINI_MEM_SWAP),y)
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 else
-   zreladdr-y	:= 0x10008000
 params_phys-y	:= 0x10000100
 initrd_phys-y	:= 0x10800000
 endif
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 7988a85..110aa36 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -1,11 +1,8 @@
-zreladdr-$(CONFIG_ARCH_MX1)	:= 0x08008000
 params_phys-$(CONFIG_ARCH_MX1)	:= 0x08000100
 initrd_phys-$(CONFIG_ARCH_MX1)	:= 0x08800000
 
-zreladdr-$(CONFIG_MACH_MX21)	:= 0xC0008000
 params_phys-$(CONFIG_MACH_MX21)	:= 0xC0000100
 initrd_phys-$(CONFIG_MACH_MX21)	:= 0xC0800000
 
-zreladdr-$(CONFIG_MACH_MX27)	:= 0xA0008000
 params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
 initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
diff --git a/arch/arm/mach-integrator/Makefile.boot b/arch/arm/mach-integrator/Makefile.boot
index c7e75ac..ee22553 100644
--- a/arch/arm/mach-integrator/Makefile.boot
+++ b/arch/arm/mach-integrator/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-iop13xx/Makefile.boot b/arch/arm/mach-iop13xx/Makefile.boot
index 0b0e19f..6e25cb5 100644
--- a/arch/arm/mach-iop13xx/Makefile.boot
+++ b/arch/arm/mach-iop13xx/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y   := 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y 	:= 0x00800000
diff --git a/arch/arm/mach-iop32x/Makefile.boot b/arch/arm/mach-iop32x/Makefile.boot
index 47000dc..5e0e4f6 100644
--- a/arch/arm/mach-iop32x/Makefile.boot
+++ b/arch/arm/mach-iop32x/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0xa0008000
 params_phys-y	:= 0xa0000100
 initrd_phys-y	:= 0xa0800000
diff --git a/arch/arm/mach-iop33x/Makefile.boot b/arch/arm/mach-iop33x/Makefile.boot
index 67039c3..80f4945 100644
--- a/arch/arm/mach-iop33x/Makefile.boot
+++ b/arch/arm/mach-iop33x/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-ixp2000/Makefile.boot b/arch/arm/mach-ixp2000/Makefile.boot
index d84c580..1bca921 100644
--- a/arch/arm/mach-ixp2000/Makefile.boot
+++ b/arch/arm/mach-ixp2000/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 
diff --git a/arch/arm/mach-ixp23xx/Makefile.boot b/arch/arm/mach-ixp23xx/Makefile.boot
index d5561ad..cb69427 100644
--- a/arch/arm/mach-ixp23xx/Makefile.boot
+++ b/arch/arm/mach-ixp23xx/Makefile.boot
@@ -1,2 +1 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
diff --git a/arch/arm/mach-ixp4xx/Makefile.boot b/arch/arm/mach-ixp4xx/Makefile.boot
index d84c580..1bca921 100644
--- a/arch/arm/mach-ixp4xx/Makefile.boot
+++ b/arch/arm/mach-ixp4xx/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 67039c3..80f4945 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-ks8695/Makefile.boot b/arch/arm/mach-ks8695/Makefile.boot
index 48eb2cb..11ea079 100644
--- a/arch/arm/mach-ks8695/Makefile.boot
+++ b/arch/arm/mach-ks8695/Makefile.boot
@@ -3,6 +3,5 @@
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
 #   INITRD_PHYS must be in RAM
 
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-lh7a40x/Makefile.boot b/arch/arm/mach-lh7a40x/Makefile.boot
index af941be..5a78392 100644
--- a/arch/arm/mach-lh7a40x/Makefile.boot
+++ b/arch/arm/mach-lh7a40x/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0xc0008000
 params_phys-y	:= 0xc0000100
 initrd_phys-y	:= 0xc4000000
 
diff --git a/arch/arm/mach-loki/Makefile.boot b/arch/arm/mach-loki/Makefile.boot
index 67039c3..80f4945 100644
--- a/arch/arm/mach-loki/Makefile.boot
+++ b/arch/arm/mach-loki/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-mmp/Makefile.boot b/arch/arm/mach-mmp/Makefile.boot
deleted file mode 100644
index 574a4aa..0000000
--- a/arch/arm/mach-mmp/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-   zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-msm/Makefile.boot b/arch/arm/mach-msm/Makefile.boot
index 24dfbf8..14acc97 100644
--- a/arch/arm/mach-msm/Makefile.boot
+++ b/arch/arm/mach-msm/Makefile.boot
@@ -1,3 +1,2 @@
-  zreladdr-y		:= 0x10008000
 params_phys-y		:= 0x10000100
 initrd_phys-y		:= 0x10800000
diff --git a/arch/arm/mach-mv78xx0/Makefile.boot b/arch/arm/mach-mv78xx0/Makefile.boot
index 67039c3..80f4945 100644
--- a/arch/arm/mach-mv78xx0/Makefile.boot
+++ b/arch/arm/mach-mv78xx0/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-mx25/Makefile.boot b/arch/arm/mach-mx25/Makefile.boot
index e1dd366..77987d8 100644
--- a/arch/arm/mach-mx25/Makefile.boot
+++ b/arch/arm/mach-mx25/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x80008000
 params_phys-y	:= 0x80000100
 initrd_phys-y	:= 0x80800000
diff --git a/arch/arm/mach-mx3/Makefile.boot b/arch/arm/mach-mx3/Makefile.boot
index e1dd366..77987d8 100644
--- a/arch/arm/mach-mx3/Makefile.boot
+++ b/arch/arm/mach-mx3/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x80008000
 params_phys-y	:= 0x80000100
 initrd_phys-y	:= 0x80800000
diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
index 9939a19..62b05d4 100644
--- a/arch/arm/mach-mx5/Makefile.boot
+++ b/arch/arm/mach-mx5/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x90008000
 params_phys-y	:= 0x90000100
 initrd_phys-y	:= 0x90800000
diff --git a/arch/arm/mach-mxc91231/Makefile.boot b/arch/arm/mach-mxc91231/Makefile.boot
index 9939a19..62b05d4 100644
--- a/arch/arm/mach-mxc91231/Makefile.boot
+++ b/arch/arm/mach-mxc91231/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x90008000
 params_phys-y	:= 0x90000100
 initrd_phys-y	:= 0x90800000
diff --git a/arch/arm/mach-netx/Makefile.boot b/arch/arm/mach-netx/Makefile.boot
deleted file mode 100644
index b81cf6a..0000000
--- a/arch/arm/mach-netx/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-    zreladdr-y			:= 0x80008000
-
diff --git a/arch/arm/mach-nomadik/Makefile.boot b/arch/arm/mach-nomadik/Makefile.boot
index c7e75ac..ee22553 100644
--- a/arch/arm/mach-nomadik/Makefile.boot
+++ b/arch/arm/mach-nomadik/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-ns9xxx/Makefile.boot b/arch/arm/mach-ns9xxx/Makefile.boot
index 5465491..bdf4f71 100644
--- a/arch/arm/mach-ns9xxx/Makefile.boot
+++ b/arch/arm/mach-ns9xxx/Makefile.boot
@@ -1,2 +1 @@
-zreladdr-y := 0x8000
 params_phys-y := 0x100
diff --git a/arch/arm/mach-nuc93x/Makefile.boot b/arch/arm/mach-nuc93x/Makefile.boot
index a057b54..1bca921 100644
--- a/arch/arm/mach-nuc93x/Makefile.boot
+++ b/arch/arm/mach-nuc93x/Makefile.boot
@@ -1,3 +1,2 @@
-zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 
diff --git a/arch/arm/mach-omap1/Makefile.boot b/arch/arm/mach-omap1/Makefile.boot
index 292d56c..14acc97 100644
--- a/arch/arm/mach-omap1/Makefile.boot
+++ b/arch/arm/mach-omap1/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y		:= 0x10008000
 params_phys-y		:= 0x10000100
 initrd_phys-y		:= 0x10800000
diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
index 565aff7..a99818f 100644
--- a/arch/arm/mach-omap2/Makefile.boot
+++ b/arch/arm/mach-omap2/Makefile.boot
@@ -1,3 +1,2 @@
-  zreladdr-y		:= 0x80008000
 params_phys-y		:= 0x80000100
 initrd_phys-y		:= 0x80800000
diff --git a/arch/arm/mach-orion5x/Makefile.boot b/arch/arm/mach-orion5x/Makefile.boot
index 67039c3..80f4945 100644
--- a/arch/arm/mach-orion5x/Makefile.boot
+++ b/arch/arm/mach-orion5x/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-pnx4008/Makefile.boot b/arch/arm/mach-pnx4008/Makefile.boot
index 44c7117..76905a0 100644
--- a/arch/arm/mach-pnx4008/Makefile.boot
+++ b/arch/arm/mach-pnx4008/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y		:= 0x80008000
 params_phys-y		:= 0x80000100
 initrd_phys-y		:= 0x80800000
 
diff --git a/arch/arm/mach-pxa/Makefile.boot b/arch/arm/mach-pxa/Makefile.boot
deleted file mode 100644
index 1ead671..0000000
--- a/arch/arm/mach-pxa/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	:= 0xa0008000
-
diff --git a/arch/arm/mach-realview/Makefile.boot b/arch/arm/mach-realview/Makefile.boot
index d97e003..886d020 100644
--- a/arch/arm/mach-realview/Makefile.boot
+++ b/arch/arm/mach-realview/Makefile.boot
@@ -1,9 +1,7 @@
 ifeq ($(CONFIG_REALVIEW_HIGH_PHYS_OFFSET),y)
-   zreladdr-y	:= 0x70008000
 params_phys-y	:= 0x70000100
 initrd_phys-y	:= 0x70800000
 else
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 endif
diff --git a/arch/arm/mach-rpc/Makefile.boot b/arch/arm/mach-rpc/Makefile.boot
index 9c9e768..3c7cc4a 100644
--- a/arch/arm/mach-rpc/Makefile.boot
+++ b/arch/arm/mach-rpc/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0x10008000
 params_phys-y	:= 0x10000100
 initrd_phys-y	:= 0x18000000
 
diff --git a/arch/arm/mach-s3c2410/Makefile.boot b/arch/arm/mach-s3c2410/Makefile.boot
index 58c1dd7..69dbda1 100644
--- a/arch/arm/mach-s3c2410/Makefile.boot
+++ b/arch/arm/mach-s3c2410/Makefile.boot
@@ -1,7 +1,5 @@
 ifeq ($(CONFIG_PM_H1940),y)
-	zreladdr-y		:= 0x30108000
 	params_phys-y	:= 0x30100100
 else
-	zreladdr-y		:= 0x30008000
 	params_phys-y	:= 0x30000100
 endif
diff --git a/arch/arm/mach-s3c64xx/Makefile.boot b/arch/arm/mach-s3c64xx/Makefile.boot
index ba41fdc..b6349bd 100644
--- a/arch/arm/mach-s3c64xx/Makefile.boot
+++ b/arch/arm/mach-s3c64xx/Makefile.boot
@@ -1,2 +1 @@
-   zreladdr-y	:= 0x50008000
 params_phys-y	:= 0x50000100
diff --git a/arch/arm/mach-s5p6440/Makefile.boot b/arch/arm/mach-s5p6440/Makefile.boot
index ff90aa1..9a79532 100644
--- a/arch/arm/mach-s5p6440/Makefile.boot
+++ b/arch/arm/mach-s5p6440/Makefile.boot
@@ -1,2 +1 @@
-   zreladdr-y	:= 0x20008000
 params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5p6442/Makefile.boot b/arch/arm/mach-s5p6442/Makefile.boot
index ff90aa1..9a79532 100644
--- a/arch/arm/mach-s5p6442/Makefile.boot
+++ b/arch/arm/mach-s5p6442/Makefile.boot
@@ -1,2 +1 @@
-   zreladdr-y	:= 0x20008000
 params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5pc100/Makefile.boot b/arch/arm/mach-s5pc100/Makefile.boot
index ff90aa1..9a79532 100644
--- a/arch/arm/mach-s5pc100/Makefile.boot
+++ b/arch/arm/mach-s5pc100/Makefile.boot
@@ -1,2 +1 @@
-   zreladdr-y	:= 0x20008000
 params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5pv210/Makefile.boot b/arch/arm/mach-s5pv210/Makefile.boot
index ff90aa1..9a79532 100644
--- a/arch/arm/mach-s5pv210/Makefile.boot
+++ b/arch/arm/mach-s5pv210/Makefile.boot
@@ -1,2 +1 @@
-   zreladdr-y	:= 0x20008000
 params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5pv310/Makefile.boot b/arch/arm/mach-s5pv310/Makefile.boot
index d65956f..85644bc 100644
--- a/arch/arm/mach-s5pv310/Makefile.boot
+++ b/arch/arm/mach-s5pv310/Makefile.boot
@@ -1,2 +1 @@
-   zreladdr-y	:= 0x40008000
 params_phys-y	:= 0x40000100
diff --git a/arch/arm/mach-sa1100/Makefile.boot b/arch/arm/mach-sa1100/Makefile.boot
index a56ad04..2690ce5 100644
--- a/arch/arm/mach-sa1100/Makefile.boot
+++ b/arch/arm/mach-sa1100/Makefile.boot
@@ -1,7 +1,2 @@
-   zreladdr-y	:= 0xc0008000
-ifeq ($(CONFIG_ARCH_SA1100),y)
-   zreladdr-$(CONFIG_SA1111)		:= 0xc0208000
-endif
 params_phys-y	:= 0xc0000100
 initrd_phys-y	:= 0xc0800000
-
diff --git a/arch/arm/mach-shark/Makefile.boot b/arch/arm/mach-shark/Makefile.boot
deleted file mode 100644
index 4320f8b..0000000
--- a/arch/arm/mach-shark/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	:= 0x08008000
-
diff --git a/arch/arm/mach-spear3xx/Makefile.boot b/arch/arm/mach-spear3xx/Makefile.boot
index 7a1f3c0..80f4945 100644
--- a/arch/arm/mach-spear3xx/Makefile.boot
+++ b/arch/arm/mach-spear3xx/Makefile.boot
@@ -1,3 +1,2 @@
-zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-spear6xx/Makefile.boot b/arch/arm/mach-spear6xx/Makefile.boot
index 7a1f3c0..80f4945 100644
--- a/arch/arm/mach-spear6xx/Makefile.boot
+++ b/arch/arm/mach-spear6xx/Makefile.boot
@@ -1,3 +1,2 @@
-zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-stmp378x/Makefile.boot b/arch/arm/mach-stmp378x/Makefile.boot
index 1568ad4..71e6728 100644
--- a/arch/arm/mach-stmp378x/Makefile.boot
+++ b/arch/arm/mach-stmp378x/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x40008000
 params_phys-y	:= 0x40000100
 initrd_phys-y	:= 0x40800000
diff --git a/arch/arm/mach-stmp37xx/Makefile.boot b/arch/arm/mach-stmp37xx/Makefile.boot
index 1568ad4..71e6728 100644
--- a/arch/arm/mach-stmp37xx/Makefile.boot
+++ b/arch/arm/mach-stmp37xx/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x40008000
 params_phys-y	:= 0x40000100
 initrd_phys-y	:= 0x40800000
diff --git a/arch/arm/mach-u300/Makefile.boot b/arch/arm/mach-u300/Makefile.boot
index 6fbfc6e..9f7ca02 100644
--- a/arch/arm/mach-u300/Makefile.boot
+++ b/arch/arm/mach-u300/Makefile.boot
@@ -4,10 +4,8 @@
 #   INITRD_PHYS must be in RAM
 
 ifdef CONFIG_MACH_U300_SINGLE_RAM
-     zreladdr-y	:= 0x28E08000
   params_phys-y	:= 0x28E00100
 else
-     zreladdr-y	:= 0x48008000
   params_phys-y	:= 0x48000100
 endif
 
diff --git a/arch/arm/mach-ux500/Makefile.boot b/arch/arm/mach-ux500/Makefile.boot
index c7e75ac..ee22553 100644
--- a/arch/arm/mach-ux500/Makefile.boot
+++ b/arch/arm/mach-ux500/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-versatile/Makefile.boot b/arch/arm/mach-versatile/Makefile.boot
index c7e75ac..ee22553 100644
--- a/arch/arm/mach-versatile/Makefile.boot
+++ b/arch/arm/mach-versatile/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 07c2d9c..9acbba0 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -1,3 +1,2 @@
-   zreladdr-y	:= 0x60008000
 params_phys-y	:= 0x60000100
 initrd_phys-y	:= 0x60800000
diff --git a/arch/arm/mach-w90x900/Makefile.boot b/arch/arm/mach-w90x900/Makefile.boot
index a057b54..1bca921 100644
--- a/arch/arm/mach-w90x900/Makefile.boot
+++ b/arch/arm/mach-w90x900/Makefile.boot
@@ -1,3 +1,2 @@
-zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 
-- 
1.7.1

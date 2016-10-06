From: paweljarosz3691@gmail.com (=?us-ascii?B?PT9VVEYtOD9xP1Bhd2U9QzU9ODI9MjBKYXJvc3o/PQ==?=)
Date: Thu, 6 Oct 2016 18:22:40 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: Enable build of rk3066 MK808 dts
In-Reply-To: <cover.1475764778.git.paweljarosz3691@gmail.com>
References: <cover.1475764778.git.paweljarosz3691@gmail.com>
Message-ID: <84d4bc0b733cb9776f03ad54bb946fd1c4be4049.1475764778.git.paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MK808 is rockchip rk3066 based board made by Rickomagic. It has two usb
ports, sdmmc, wifi and uart onboard.

Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..f19cc1d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -639,6 +639,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3036-kylin.dtb \
 	rk3066a-bqcurie2.dtb \
 	rk3066a-marsboard.dtb \
+	rk3066a-mk808.dtb \
 	rk3066a-rayeager.dtb \
 	rk3188-radxarock.dtb \
 	rk3228-evb.dtb \
-- 
2.7.4

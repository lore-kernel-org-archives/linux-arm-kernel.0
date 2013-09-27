From: balajitk@ti.com (Balaji T K)
Date: Fri, 27 Sep 2013 17:05:10 +0530
Subject: [PATCH 2/2] ARM: dts: am335x-evm,
 am335x-evmsdk: switch mmc1 to 4-bit mode
In-Reply-To: <1380281710-12728-1-git-send-email-balajitk@ti.com>
References: <1380281710-12728-1-git-send-email-balajitk@ti.com>
Message-ID: <1380281710-12728-2-git-send-email-balajitk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set bus-width to make SD card operate in 4 bit mode.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
based on git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts

 arch/arm/boot/dts/am335x-evm.dts   |    1 +
 arch/arm/boot/dts/am335x-evmsk.dts |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 23b0a3e..028ca09 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -521,4 +521,5 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vmmc_reg>;
+	bus-width = <4>;
 };
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index bc93895..563a2b1 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -423,4 +423,5 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vmmc_reg>;
+	bus-width = <4>;
 };
-- 
1.7.5.4

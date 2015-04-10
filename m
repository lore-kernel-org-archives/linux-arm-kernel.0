From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Fri, 10 Apr 2015 10:16:20 +0300
Subject: [PATCH 2/2] ARM: defconfig: hisi: enable HiSilicon hip04 ethernet
 controller
In-Reply-To: <1428650180-9746-1-git-send-email-fathi.boudra@linaro.org>
References: <1428650180-9746-1-git-send-email-fathi.boudra@linaro.org>
Message-ID: <1428650180-9746-3-git-send-email-fathi.boudra@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 arch/arm/configs/hisi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index c34da58..e34314a 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -33,6 +33,7 @@ CONFIG_ATA=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_NETDEVICES=y
 CONFIG_HIX5HD2_GMAC=y
+CONFIG_HIP04_ETH=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
 CONFIG_SERIAL_8250_CONSOLE=y
-- 
2.1.4

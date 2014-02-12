From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 18:21:02 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: enable audio options in mvebu_defconfig
In-Reply-To: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392225662-20431-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since at least the Armada 370 SoC has audio support, it makes sense to
enable the corresponding kernel configuration options in
mvebu_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 0f4511d..5c58559 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -62,6 +62,11 @@ CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_KIRKWOOD_SOC=y
+CONFIG_SND_KIRKWOOD_SOC_ARMADA370_DB=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.8.3.2

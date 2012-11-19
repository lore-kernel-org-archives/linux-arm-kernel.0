From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 12:16:28 +0100
Subject: [PATCH 2/2] arm: mvebu: update defconfig to include XOR driver
In-Reply-To: <1353323788-17474-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353323788-17474-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353323788-17474-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index b9adce1..5c79474 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -39,6 +39,8 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_DMADEVICES=y
+CONFIG_MV_XOR=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.7.9.5

From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:51 -0700
Subject: [PATCH 27/47] davinci: Add CONFIG_REGULATOR_DUMMY to DA8XX defconfig
	file.
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-28-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Williamson <michael.williamson@criticallink.com>

In order to support reference DA8XX machines not providing a
voltage regulator control for the core voltage, the REGULATOR_DUMMY
option is required.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/configs/da8xx_omapl_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index ba66705..3952a4e 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -79,6 +79,7 @@ CONFIG_I2C_DAVINCI=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_DUMMY=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_FB=y
 CONFIG_FB_DA8XX=y
-- 
1.7.2.1

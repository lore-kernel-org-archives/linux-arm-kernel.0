From: vigneshr@ti.com (Vignesh R)
Date: Mon, 7 Aug 2017 17:19:43 +0530
Subject: [PATCH 4/4] ARM: configs: keystone: Enable TIECAP PWM driver
In-Reply-To: <20170807114943.22612-1-vigneshr@ti.com>
References: <20170807114943.22612-1-vigneshr@ti.com>
Message-ID: <20170807114943.22612-5-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PWM_TIECAP driver to support ECAP IP present in 66AK2G SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index d47ea43d097e..445ad438b451 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -182,6 +182,8 @@ CONFIG_KEYSTONE_NAVIGATOR_DMA=y
 CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=y
+CONFIG_PWM=y
+CONFIG_PWM_TIECAP=m
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_RESET_TI_SCI=m
 CONFIG_RESET_TI_SYSCON=m
-- 
2.13.3

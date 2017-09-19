From: vigneshr@ti.com (Vignesh R)
Date: Tue, 19 Sep 2017 11:45:51 +0530
Subject: [RESEND PATCH 3/3] ARM: configs: keystone: Enable TIECAP PWM driver
In-Reply-To: <20170919061551.11981-1-vigneshr@ti.com>
References: <20170919061551.11981-1-vigneshr@ti.com>
Message-ID: <20170919061551.11981-4-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PWM_TIECAP driver to support ECAP IP present in 66AK2G SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index f907869e0ddc..f710c192b33a 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -189,6 +189,8 @@ CONFIG_KEYSTONE_NAVIGATOR_DMA=y
 CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=y
+CONFIG_PWM=y
+CONFIG_PWM_TIECAP=m
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_RESET_TI_SCI=m
 CONFIG_RESET_TI_SYSCON=m
-- 
2.14.1

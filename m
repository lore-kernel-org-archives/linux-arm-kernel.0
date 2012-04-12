From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Apr 2012 22:12:12 -0300
Subject: [PATCH 4/4] ARM: imx_v4_v5_defconfig: Let CONFIG_MACH_IMX27_DT be
 built by default
In-Reply-To: <1334193132-18944-1-git-send-email-festevam@gmail.com>
References: <1334193132-18944-1-git-send-email-festevam@gmail.com>
Message-ID: <1334193132-18944-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let CONFIG_MACH_IMX27_DT be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index b5ac644..b654f1d 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -33,6 +33,7 @@ CONFIG_MACH_IMX27LITE=y
 CONFIG_MACH_PCA100=y
 CONFIG_MACH_MXT_TD60=y
 CONFIG_MACH_IMX27IPCAM=y
+CONFIG_MACH_IMX27_DT=y
 CONFIG_MXC_IRQ_PRIOR=y
 CONFIG_MXC_PWM=y
 CONFIG_NO_HZ=y
-- 
1.7.1

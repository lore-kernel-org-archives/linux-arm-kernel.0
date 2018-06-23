From: david@lechnology.com (David Lechner)
Date: Sat, 23 Jun 2018 16:08:08 -0500
Subject: [PATCH 6/8] ARM: davinci_all_defconfig: enable PRU remoteproc module
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
Message-ID: <20180623210810.21232-7-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enabled the remoteproc module for the PRU on DA8xx-type devices.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a1b6e106b867..1bcc7c6a03ee 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -214,6 +214,8 @@ CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_REMOTEPROC=m
 CONFIG_DA8XX_REMOTEPROC=m
+CONFIG_TI_PRU_REMOTEPROC=m
+CONFIG_RPMSG_VIRTIO=m
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
-- 
2.17.1

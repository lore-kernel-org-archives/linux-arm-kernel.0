From: ian@opensource.wolfsonmicro.com (Ian Lartey)
Date: Thu, 30 Sep 2010 16:47:35 +0100
Subject: [PATCH 2/2] Adding cs89x0,
	standard ethernet driver for iMX31 platform.
In-Reply-To: <1285861655-6513-1-git-send-email-ian@opensource.wolfsonmicro.com>
References: <1285861655-6513-1-git-send-email-ian@opensource.wolfsonmicro.com>
Message-ID: <1285861655-6513-2-git-send-email-ian@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 arch/arm/configs/mx3_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
index 161f907..b0b3409 100644
--- a/arch/arm/configs/mx3_defconfig
+++ b/arch/arm/configs/mx3_defconfig
@@ -68,6 +68,8 @@ CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
 CONFIG_DNET=y
 CONFIG_FEC=y
+CONFIG_CS89x0=y
+CONFIG_CS89x0_NONISA_IRQ=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT is not set
-- 
1.7.0.4

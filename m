From: vbyravarasu@nvidia.com (Venu Byravarasu)
Date: Thu, 13 Sep 2012 10:46:25 +0530
Subject: [PATCH] arm: tegra: fixing compilation error
Message-ID: <1347513385-14158-1-git-send-email-vbyravarasu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usb_phy.h got moved from mach to include/linux/usb
and renamed as tegra_usb_phy.h, correcting it in the include
path.

Signed-off-by: Venu Byravarasu <vbyravarasu@nvidia.com>
---
 arch/arm/mach-tegra/board-dt-tegra20.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index adc6b98..3308a65 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -41,7 +41,7 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
-#include <mach/usb_phy.h>
+#include <linux/usb/tegra_usb_phy.h>
 
 #include "board.h"
 #include "clock.h"
-- 
1.7.1.1

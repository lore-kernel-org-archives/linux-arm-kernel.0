From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 16:10:40 -0700
Subject: [PATCH] ARM: tegra: Harmony PCIe: Remove unnecessary include
Message-ID: <1326323440-23977-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file no longer uses pinmux APIs, and hence doesn't need to include
a pinmux header.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony-pcie.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
index 1fc5c57..33c4fed 100644
--- a/arch/arm/mach-tegra/board-harmony-pcie.c
+++ b/arch/arm/mach-tegra/board-harmony-pcie.c
@@ -22,7 +22,6 @@
 
 #include <asm/mach-types.h>
 
-#include <mach/pinmux-tegra20.h>
 #include "board.h"
 #include "board-harmony.h"
 
-- 
1.7.0.4

From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 16 Dec 2011 15:12:27 -0700
Subject: [PATCH 4/9] arm/tegra: PCIe: Remove include of mach/pinmux.h
In-Reply-To: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
References: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324073552-15542-5-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing in this file needs this header.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/pcie.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 92947d8..af8b634 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -37,7 +37,6 @@
 #include <asm/sizes.h>
 #include <asm/mach/pci.h>
 
-#include <mach/pinmux.h>
 #include <mach/iomap.h>
 #include <mach/clk.h>
 #include <mach/powergate.h>
-- 
1.7.0.4

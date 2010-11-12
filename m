From: vm.rod25@gmail.com (vm.rod25 at gmail.com)
Date: Fri, 12 Nov 2010 16:38:50 -0600
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
Message-ID: <1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch defines Pin Mux configuration for MacASP
used on the Hawkboard-L138 system in order to add Audio support

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
Tested-by: Rene Gonzalez <renegs.2378@gmail.com>
---
 arch/arm/mach-davinci/da850.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 63916b9..f033a0a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -591,7 +591,7 @@ const short da850_cpgmac_pins[] __initdata = {
 const short da850_mcasp_pins[] __initdata = {
 	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
 	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
-	DA850_AXR_11, DA850_AXR_12,
+	DA850_AXR_11, DA850_AXR_12, DA850_AXR_13, DA850_AXR_14,
 	-1
 };
 
-- 
1.7.0.4

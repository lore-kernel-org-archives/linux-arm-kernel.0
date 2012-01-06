From: davidb@codeaurora.org (David Brown)
Date: Fri,  6 Jan 2012 11:21:24 -0800
Subject: [PATCH] ARM: msm: vreg is a module and so needs module.h
Message-ID: <1325877684-14095-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM7201 vreg appears to have gotten missed in the module.h
cleanup.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/vreg.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/vreg.c b/arch/arm/mach-msm/vreg.c
index a9103bc..bd66ed0 100644
--- a/arch/arm/mach-msm/vreg.c
+++ b/arch/arm/mach-msm/vreg.c
@@ -19,6 +19,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
+#include <linux/module.h>
 #include <linux/string.h>
 #include <mach/vreg.h>
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

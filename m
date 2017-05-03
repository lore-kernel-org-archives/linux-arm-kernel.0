From: timur@codeaurora.org (Timur Tabi)
Date: Wed,  3 May 2017 11:52:26 -0500
Subject: [PATCH] [v2] MAINTAINERS: arm64 defconfig changes should go to
 arm@kernel.org
Message-ID: <1493830346-16406-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any changes to arch/arm64/configs/defconfig must be sent to arm at kernel.org,
otherwise they will not get picked up.  Add a MAINTAINERS entry to ensure
the get_maintainers includes it.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58590cf..5d15858 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2066,6 +2066,11 @@ S:	Maintained
 F:	arch/arm64/
 F:	Documentation/arm64/
 
+ARM64 DEFCONFIG
+M:	arm at kernel.org
+S:	Maintained
+F:	arch/arm64/configs/defconfig
+
 AS3645A LED FLASH CONTROLLER DRIVER
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media at vger.kernel.org
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

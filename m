From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Nov 2010 17:03:30 -0800
Subject: [PATCH 3/4] OMAP1: camera.h: add missing include
In-Reply-To: <20101112010245.3827.75329.stgit@baageli.muru.com>
References: <20101112010245.3827.75329.stgit@baageli.muru.com>
Message-ID: <20101112010330.3827.16286.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

#include <media/omap1_camera.h> directive is required to
compile the dependant boards (board-ams-delta for now).

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
[tony at atomide.com: updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/camera.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/camera.h b/arch/arm/mach-omap1/include/mach/camera.h
index fd54b45..847d00f 100644
--- a/arch/arm/mach-omap1/include/mach/camera.h
+++ b/arch/arm/mach-omap1/include/mach/camera.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_ARCH_CAMERA_H_
 #define __ASM_ARCH_CAMERA_H_
 
+#include <media/omap1_camera.h>
+
 void omap1_camera_init(void *);
 
 static inline void omap1_set_camera_info(struct omap1_cam_platform_data *info)

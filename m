From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Mon, 11 Apr 2016 16:55:43 +0800
Subject: [PATCH v8 10/10] MAINTAINERS: Add maintainer for hisilicon DRM driver
In-Reply-To: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
References: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1460364943-76135-11-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer and reviewer for hisilicon DRM driver.

v8: None.
v7: None.
v6: None.
v5: None.
v4:
- Add Chen Feng <puck.chen@hisilicon.com> as Designated reviewer.
v3: First version.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61a323a6b2cf..a2ef58860689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3840,6 +3840,16 @@ S:	Maintained
 F:	drivers/gpu/drm/gma500
 F:	include/drm/gma500*
 
+DRM DRIVERS FOR HISILICON
+M:	Xinliang Liu <z.liuxinliang@hisilicon.com>
+R:	Xinwei Kong <kong.kongxinwei@hisilicon.com>
+R:	Chen Feng <puck.chen@hisilicon.com>
+L:	dri-devel at lists.freedesktop.org
+T:	git git://github.com/xin3liang/linux.git
+S:	Maintained
+F:	drivers/gpu/drm/hisilicon
+F:	Documentation/devicetree/bindings/display/hisilicon
+
 DRM DRIVERS FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
 M:	Terje Bergstr?m <tbergstrom@nvidia.com>
-- 
2.8.0

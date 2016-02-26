From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Fri, 26 Feb 2016 16:40:27 +0800
Subject: [PATCH v6 10/11] MAINTAINERS: Add maintainer for hisilicon DRM driver
In-Reply-To: <1456476028-36880-1-git-send-email-xinliang.liu@linaro.org>
References: <1456476028-36880-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1456476028-36880-11-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer and reviewer for hisilicon DRM driver.

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
index 4978dc19a4d2..b94ac713916a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3774,6 +3774,16 @@ S:	Maintained
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
2.7.1

From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat,  6 Feb 2016 11:24:57 +0800
Subject: [PATCH v4 10/11] MAINTAINERS: Add maintainer for hisilicon DRM driver
In-Reply-To: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
References: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1454729098-79807-11-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer and reviewer for hisilicon DRM driver.

v4:
- Add Chen Feng <puck.chen@hisilicon.com> as Designated reviewer.
v3: First version.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30aca4aa5467..730ebc571edf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3777,6 +3777,16 @@ S:	Maintained
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
 M:	Terje Bergstr??m <tbergstrom@nvidia.com>
-- 
1.9.1

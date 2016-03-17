From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 17 Mar 2016 11:13:30 +0000
Subject: [PATCH] MAINTAINERS: Add the stlinux kernel mailing list for the STi
 drm driver.
Message-ID: <1458213210-13873-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most drivers for STi are under the ARM/STI Architecture section which
includes this mailing list.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ee06ea..c541a89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3814,6 +3814,7 @@ DRM DRIVERS FOR STI
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 M:	Vincent Abriou <vincent.abriou@st.com>
 L:	dri-devel at lists.freedesktop.org
+L:	kernel at stlinux.com
 T:	git http://git.linaro.org/people/benjamin.gaignard/kernel.git
 S:	Maintained
 F:	drivers/gpu/drm/sti
-- 
1.9.1

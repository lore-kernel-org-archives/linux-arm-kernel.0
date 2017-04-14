From: yannick.fertre@st.com (Yannick Fertre)
Date: Fri, 14 Apr 2017 10:10:51 +0200
Subject: [PATCH v6 5/9] [media] add maintainers for DRM STM driver
In-Reply-To: <1492157455-2283-1-git-send-email-yannick.fertre@st.com>
References: <1492157455-2283-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1492157455-2283-6-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Philippe Cornu and myself as maintainers.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c36dfae..84cf73f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4424,6 +4424,15 @@ S:	Maintained
 F:	drivers/gpu/drm/sti
 F:	Documentation/devicetree/bindings/display/st,stih4xx.txt
 
+DRM DRIVERS FOR STM
+M:	Yannick Fertre <yannick.fertre@st.com>
+M:	Philippe Cornu <philippe.cornu@st.com>
+L:	dri-devel at lists.freedesktop.org
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+S:	Maintained
+F:	drivers/gpu/drm/stm
+F:	Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+
 DRM DRIVER FOR TDFX VIDEO CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/tdfx/
-- 
1.9.1

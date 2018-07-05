From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Thu, 5 Jul 2018 11:01:42 +0200
Subject: [PATCH] MAINTAINERS: Add entry for STM32 DCMI media driver
Message-ID: <1530781302-6675-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry to make myself a maintainer of STM32 DCMI media driver.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07d1576..1032c05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8955,6 +8955,14 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/dvb-frontends/stv6111*
 
+MEDIA DRIVERS FOR STM32 - DCMI
+M:	Hugues Fruchet <hugues.fruchet@st.com>
+L:	linux-media at vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Supported
+F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
+F:	drivers/media/platform/stm32/stm32-dcmi.c
+
 MEDIA DRIVERS FOR NVIDIA TEGRA - VDE
 M:	Dmitry Osipenko <digetx@gmail.com>
 L:	linux-media at vger.kernel.org
-- 
1.9.1

From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Thu,  1 Mar 2018 16:09:15 +0800
Subject: [PATCH] MAINTAINERS: Add Spreadtrum SoC entry
Message-ID: <1519891755-17135-1-git-send-email-zhang.lyra@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Spreadtrum's maintainer entry and Orson, Baolin and me
as maintainers.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>

Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c104db..d232df9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1972,6 +1972,14 @@ M:	Thor Thayer <thor.thayer@linux.intel.com>
 S:	Maintained
 F:	drivers/edac/altera_edac.
 
+ARM/SPREADTRUM SoC SUPPORT
+M:	Orson Zhai <orsonzhai@gmail.com>
+M:	Baolin Wang <baolin.wang@linaro.org>
+M:	Chunyan Zhang <zhang.lyra@gmail.com>
+S:	Maintained
+F:	arch/arm64/boot/dts/sprd
+N:	sprd
+
 ARM/STI ARCHITECTURE
 M:	Patrice Chotard <patrice.chotard@st.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.7.4

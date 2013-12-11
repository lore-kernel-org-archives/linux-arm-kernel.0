From: mohit.kumar@st.com (Mohit Kumar)
Date: Wed, 11 Dec 2013 15:08:36 +0530
Subject: [PATCH 11/12] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Message-ID: <0f924b2ad771dd5c3486c81ed524a3f6e7d813b9.1386752447.git.mohit.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mohit Kumar as maintainer for ST SPEAr13xx PCIe driver.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci at vger.kernel.org
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8285ed4..fd03da6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6462,6 +6462,12 @@ L:	linux-pci at vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/pci-exynos.c
 
+PCIE DRIVER FOR ST SPEAR13XX
+M:	Mohit Kumar <mohit.kumar@st.com>
+L:	linux-pci at vger.kernel.org
+S:	Maintained
+F:	drivers/pci/host/pcie-spear13xx.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia at lists.infradead.org
-- 
1.7.0.1

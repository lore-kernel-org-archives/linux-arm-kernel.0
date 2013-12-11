From: mohit.kumar@st.com (Mohit Kumar)
Date: Wed, 11 Dec 2013 15:08:37 +0530
Subject: [PATCH 12/12] MAINTAINERS: Add Synopsis Designware PCIe driver
 maintainer
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Message-ID: <b55c47d431a65db45fd25ff2f3a6b77b6430e633.1386752447.git.mohit.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mohit Kumar and Jingoo Han as maintainer for Synopsis Designware PCIe driver.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci at vger.kernel.org
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd03da6..3ec2a36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6468,6 +6468,13 @@ L:	linux-pci at vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/pcie-spear13xx.c
 
+PCIE DRIVER FOR SYNOPSIS DESIGNWARE CONTROLLER
+M:	Mohit Kumar <mohit.kumar@st.com>
+M:	Jingoo Han <jg1.han@samsung.com>
+L:	linux-pci at vger.kernel.org
+S:	Maintained
+F:	drivers/pci/host/pcie-designware.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia at lists.infradead.org
-- 
1.7.0.1

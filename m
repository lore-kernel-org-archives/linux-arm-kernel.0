From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:34 -0500
Subject: [PATCH v2 01/11] ARM: davinci: defined missing CFGCHIP2_REFFREQ_*
 macros for MUSB PHY
In-Reply-To: <1458181615-27782-1-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
Message-ID: <1458181615-27782-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Petr Kulhavy <petr@barix.com>

Only few MUSB PHY reference clock  frequencies were defined.
This patch defines macros for the missing frequencies:
19.2MHz, 38.4MHz, 13MHz, 26MHz, 20MHz, 40MHz

Signed-off-by: Petr Kulhavy <petr@barix.com>.
Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
---

v2 changes: None.

 include/linux/platform_data/usb-davinci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index e0bc4ab..961d3dc 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -33,6 +33,12 @@
 #define CFGCHIP2_REFFREQ_12MHZ	(1 << 0)
 #define CFGCHIP2_REFFREQ_24MHZ	(2 << 0)
 #define CFGCHIP2_REFFREQ_48MHZ	(3 << 0)
+#define CFGCHIP2_REFFREQ_19_2MHZ	(4 << 0)
+#define CFGCHIP2_REFFREQ_38_4MHZ	(5 << 0)
+#define CFGCHIP2_REFFREQ_13MHZ	(6 << 0)
+#define CFGCHIP2_REFFREQ_26MHZ	(7 << 0)
+#define CFGCHIP2_REFFREQ_20MHZ	(8 << 0)
+#define CFGCHIP2_REFFREQ_40MHZ	(9 << 0)
 
 struct	da8xx_ohci_root_hub;
 
-- 
1.9.1

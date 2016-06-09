From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu,  9 Jun 2016 17:18:19 +0100
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for Mali-DP driver
In-Reply-To: <1465489099-25628-1-git-send-email-Liviu.Dudau@arm.com>
References: <1465489099-25628-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1465489099-25628-4-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MAINTAINERS entry for ARM Mali-DP driver and update the
HDLCD file matching pattern to cover only HDLCD rather than
the whole drivers/gpu/drm/arm directory.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81382b2..2581ea4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -865,9 +865,17 @@ F:	Documentation/devicetree/bindings/display/snps,arcpgu.txt
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
-F:	drivers/gpu/drm/arm/
+F:	drivers/gpu/drm/arm/hdlcd_*
 F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
 
+ARM MALI-DP DRM DRIVER
+M:	Liviu Dudau <liviu.dudau@arm.com>
+M:	Brian Starkey <brian.starkey@arm.com>
+M:	Mali DP Maintainers <malidp@foss.arm.com>
+S:	Supported
+F:	drivers/gpu/drm/arm/
+F:	Documentation/devicetree/bindings/display/arm,malidp.txt
+
 ARM MFM AND FLOPPY DRIVERS
 M:	Ian Molton <spyro@f2s.com>
 S:	Maintained
-- 
2.8.2

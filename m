From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue,  8 Apr 2014 20:59:48 +0800
Subject: [PATCH V3] ACPI: Update the ownership and developers for ACPI in
 Kconfig
Message-ID: <1396961988-27557-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UEFI Forum included the ACPI spec in its portfolio in October 2013
and will host future spec iterations, following the ACPI v5.0a release.

A UEFI Forum working group named ACPI Specification Working Group (ASWG)
has been established to handle future ACPI developments, any UEFI member
can join the group and contribute to ACPI specification.

So update the ownership and developers for ACPI in Kconfig accordingly,
and add another website link to ACPI specification too.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c205653..ab686b3 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -31,10 +31,14 @@ menuconfig ACPI
 	  ACPI CA, see:
 	  <http://acpica.org/>
 
-	  ACPI is an open industry specification co-developed by
-	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
+	  ACPI is an open industry specification originally co-developed by
+	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba. Currently,
+	  it is developed by the ACPI Specification Working Group (ASWG) under
+	  the UEFI Forum and any UEFI member can join the ASWG and contribute
+	  to the ACPI specification.
 	  The specification is available at:
 	  <http://www.acpi.info>
+	  <http://www.uefi.org/acpi/specs>
 
 if ACPI
 
-- 
1.7.9.5

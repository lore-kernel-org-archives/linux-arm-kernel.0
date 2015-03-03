From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:41:07 +0100
Subject: [PATCH v3 12/20] devicetree: bindings: add new SMP enable method for
 Marvell Armada 39x
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the ARM CPUs Device Tree binding to document a new
enable method of Marvell Armada 39x processors.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 8b9e0a9..6aa331d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -192,6 +192,7 @@ nodes to be present and contain the properties described below.
 			    "brcm,brahma-b15"
 			    "marvell,armada-375-smp"
 			    "marvell,armada-380-smp"
+			    "marvell,armada-390-smp"
 			    "marvell,armada-xp-smp"
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
-- 
2.1.0

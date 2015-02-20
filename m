From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 18:04:28 +0100
Subject: [PATCHv2 09/15] devicetree: bindings: add new SMP enable method for
 Marvell Armada 39x
In-Reply-To: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1424451874-25375-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the ARM CPUs Device Tree binding to document a new
enable method of Marvell Armada 39x processors.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index b2aacbe..eb13d2e 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -191,6 +191,7 @@ nodes to be present and contain the properties described below.
 			    "brcm,brahma-b15"
 			    "marvell,armada-375-smp"
 			    "marvell,armada-380-smp"
+			    "marvell,armada-390-smp"
 			    "marvell,armada-xp-smp"
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
-- 
2.1.0

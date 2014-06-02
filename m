From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Mon,  2 Jun 2014 11:21:03 +0200
Subject: [PATCH 2/5] Documentation: bindings: document the Marvell Berlin
 enable-method
In-Reply-To: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401700866-24804-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMP support for Marvell Berlin SoCs introduce a new enable-method.
Document it.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 333f4aea3029..50ec9ae6de28 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -185,6 +185,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "marvell,berlin-smp"
 
 	- cpu-release-addr
 		Usage: required for systems that have an "enable-method"
-- 
1.9.1

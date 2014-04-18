From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Apr 2014 21:01:49 +0200
Subject: [PATCH 1/5] Documentation: dt: bindings: Document ARM PSCI enable
 method
In-Reply-To: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1397847713-28418-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm,psci is also a valid enable-method for the CPUs on ARM. Document it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 333f4aea3029..ad6f7758d6ba 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -182,6 +182,7 @@ nodes to be present and contain the properties described below.
 			     "psci"
 			# On ARM 32-bit systems this property is optional and
 			  can be one of:
+			    "arm,psci"
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
-- 
1.9.1

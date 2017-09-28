From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 28 Sep 2017 16:14:53 -0700
Subject: [PATCH v2 01/10] MAINTAINERS: Update Broadcom iProc regexp with
 Hurricane 2
In-Reply-To: <20170928231502.27069-1-f.fainelli@gmail.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
Message-ID: <20170928231502.27069-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Broadcom iProc regepx with recently added Hurricane 2 SoC
support.

Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6671f375f7fc..3b48a1c2ddb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2923,6 +2923,7 @@ N:	bcm583*
 N:	bcm585*
 N:	bcm586*
 N:	bcm88312
+N:	hr2
 F:	arch/arm64/boot/dts/broadcom/ns2*
 F:	drivers/clk/bcm/clk-ns*
 F:	drivers/pinctrl/bcm/pinctrl-ns*
-- 
2.14.1

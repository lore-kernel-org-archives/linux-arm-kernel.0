From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Nov 2015 15:25:16 -0800
Subject: [PATCH 2/2] MAINTAINERS: gpio-brcmstb: Remove stray '>'
In-Reply-To: <1447889116-19293-1-git-send-email-f.fainelli@gmail.com>
References: <1447889116-19293-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1447889116-19293-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a stray '>' at the end of the mailing-list specified for the
Broadcom STB GPIO driver, remove that.

Fixes: 3b0213d56eb7 ("gpio: Add GPIO support for Broadcom STB SoCs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08f9ed61412b..b92ead35613f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2430,7 +2430,7 @@ N:	bcm88312
 
 BROADCOM BRCMSTB GPIO DRIVER
 M:	Gregory Fong <gregory.0xf0@gmail.com>
-L:	bcm-kernel-feedback-list at broadcom.com>
+L:	bcm-kernel-feedback-list at broadcom.com
 S:	Supported
 F:	drivers/gpio/gpio-brcmstb.c
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
-- 
2.1.0

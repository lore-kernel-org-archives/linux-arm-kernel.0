From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 18 Mar 2015 12:24:05 -0700
Subject: [PATCH] dt-bindings: brcm: rationalize Broadcom documentation naming
Message-ID: <1426706645-19313-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset attempts to standarize the naming of dt-bindings
documents based on the Broadcom vendor prefix of brcm.

Although there are no guidelines currently present for how to name
the dt-bindings document the "vendor,binding.txt" style is in use by
some of the other vendors.
---
 .../arm/bcm/{brcm,bcm11351-cpu-method => brcm,bcm11351-cpu-method.txt}    | 0
 .../devicetree/bindings/arm/bcm/{bcm11351.txt => brcm,bcm11351.txt}       | 0
 .../devicetree/bindings/arm/bcm/{bcm21664.txt => brcm,bcm21664.txt}       | 0
 .../devicetree/bindings/arm/{bcm2835.txt => bcm/brcm,bcm2835.txt}         | 0
 .../devicetree/bindings/arm/{bcm4708.txt => bcm/brcm,bcm4708.txt}         | 0
 .../devicetree/bindings/arm/bcm/{bcm63138.txt => brcm,bcm63138.txt}       | 0
 .../devicetree/bindings/arm/{brcm-brcmstb.txt => bcm/brcm,brcmstb.txt}    | 0
 Documentation/devicetree/bindings/arm/bcm/{cygnus.txt => brcm,cygnus.txt} | 0
 Documentation/devicetree/bindings/bus/{bcma.txt => brcm,bus-axi.txt}      | 0
 .../devicetree/bindings/clock/{bcm-kona-clock.txt => brcm,kona-ccu.txt}   | 0
 .../devicetree/bindings/dma/{bcm2835-dma.txt => brcm,bcm2835-dma.txt}     | 0
 Documentation/devicetree/bindings/mfd/{bcm590xx.txt => brcm,bcm59056.txt} | 0
 .../bindings/mips/brcm/{bcm3384-intc.txt => brcm,bcm3384-intc.txt}        | 0
 Documentation/devicetree/bindings/mips/brcm/{bmips.txt => brcm,bmips.txt} | 0
 .../devicetree/bindings/mips/brcm/{cm-dsl.txt => brcm,cm-dsl.txt}         | 0
 .../bindings/net/{broadcom-sf2.txt => brcm,bcm7445-switch-v4.0.txt}       | 0
 .../devicetree/bindings/net/{broadcom-bcmgenet.txt => brcm,bcmgenet.txt}  | 0
 .../bindings/net/{broadcom-systemport.txt => brcm,systemport.txt}         | 0
 .../bindings/net/{broadcom-mdio-unimac.txt => brcm,unimac-mdio.txt}       | 0
 .../devicetree/bindings/phy/{bcm-phy.txt => brcm,kona-usb2-phy.txt}       | 0
 .../devicetree/bindings/pwm/{bcm-kona-pwm.txt => brcm,kona-pwm.txt}       | 0
 .../{arm/bcm/kona-resetmgr.txt => reset/brcm,bcm21664-resetmgr.txt}       | 0
 .../bindings/serial/{bcm63xx-uart.txt => brcm,bcm6345-uart.txt}           | 0
 .../devicetree/bindings/sound/{bcm2835-i2s.txt => brcm,bcm2835-i2s.txt}   | 0
 .../bindings/{arm/bcm/kona-timer.txt => timer/brcm,kona-timer.txt}        | 0
 .../devicetree/bindings/{mips/brcm/usb.txt => usb/brcm,bcm3384-usb.txt}   | 0
 .../bindings/{arm/bcm/kona-wdt.txt => watchdog/brcm,kona-wdt.txt}         | 0
 27 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/bcm/{brcm,bcm11351-cpu-method => brcm,bcm11351-cpu-method.txt} (100%)
 rename Documentation/devicetree/bindings/arm/bcm/{bcm11351.txt => brcm,bcm11351.txt} (100%)
 rename Documentation/devicetree/bindings/arm/bcm/{bcm21664.txt => brcm,bcm21664.txt} (100%)
 rename Documentation/devicetree/bindings/arm/{bcm2835.txt => bcm/brcm,bcm2835.txt} (100%)
 rename Documentation/devicetree/bindings/arm/{bcm4708.txt => bcm/brcm,bcm4708.txt} (100%)
 rename Documentation/devicetree/bindings/arm/bcm/{bcm63138.txt => brcm,bcm63138.txt} (100%)
 rename Documentation/devicetree/bindings/arm/{brcm-brcmstb.txt => bcm/brcm,brcmstb.txt} (100%)
 rename Documentation/devicetree/bindings/arm/bcm/{cygnus.txt => brcm,cygnus.txt} (100%)
 rename Documentation/devicetree/bindings/bus/{bcma.txt => brcm,bus-axi.txt} (100%)
 rename Documentation/devicetree/bindings/clock/{bcm-kona-clock.txt => brcm,kona-ccu.txt} (100%)
 rename Documentation/devicetree/bindings/dma/{bcm2835-dma.txt => brcm,bcm2835-dma.txt} (100%)
 rename Documentation/devicetree/bindings/mfd/{bcm590xx.txt => brcm,bcm59056.txt} (100%)
 rename Documentation/devicetree/bindings/mips/brcm/{bcm3384-intc.txt => brcm,bcm3384-intc.txt} (100%)
 rename Documentation/devicetree/bindings/mips/brcm/{bmips.txt => brcm,bmips.txt} (100%)
 rename Documentation/devicetree/bindings/mips/brcm/{cm-dsl.txt => brcm,cm-dsl.txt} (100%)
 rename Documentation/devicetree/bindings/net/{broadcom-sf2.txt => brcm,bcm7445-switch-v4.0.txt} (100%)
 rename Documentation/devicetree/bindings/net/{broadcom-bcmgenet.txt => brcm,bcmgenet.txt} (100%)
 rename Documentation/devicetree/bindings/net/{broadcom-systemport.txt => brcm,systemport.txt} (100%)
 rename Documentation/devicetree/bindings/net/{broadcom-mdio-unimac.txt => brcm,unimac-mdio.txt} (100%)
 rename Documentation/devicetree/bindings/phy/{bcm-phy.txt => brcm,kona-usb2-phy.txt} (100%)
 rename Documentation/devicetree/bindings/pwm/{bcm-kona-pwm.txt => brcm,kona-pwm.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/bcm/kona-resetmgr.txt => reset/brcm,bcm21664-resetmgr.txt} (100%)
 rename Documentation/devicetree/bindings/serial/{bcm63xx-uart.txt => brcm,bcm6345-uart.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{bcm2835-i2s.txt => brcm,bcm2835-i2s.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/bcm/kona-timer.txt => timer/brcm,kona-timer.txt} (100%)
 rename Documentation/devicetree/bindings/{mips/brcm/usb.txt => usb/brcm,bcm3384-usb.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/bcm/kona-wdt.txt => watchdog/brcm,kona-wdt.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method
rename to Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
rename to Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm21664.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm/bcm21664.txt
rename to Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm2835.txt
rename to Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm4708.txt
rename to Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
rename to Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt
diff --git a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
rename to Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm/cygnus.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm/cygnus.txt
rename to Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
diff --git a/Documentation/devicetree/bindings/bus/bcma.txt b/Documentation/devicetree/bindings/bus/brcm,bus-axi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/bus/bcma.txt
rename to Documentation/devicetree/bindings/bus/brcm,bus-axi.txt
diff --git a/Documentation/devicetree/bindings/clock/bcm-kona-clock.txt b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt
similarity index 100%
rename from Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
rename to Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt
diff --git a/Documentation/devicetree/bindings/dma/bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
similarity index 100%
rename from Documentation/devicetree/bindings/dma/bcm2835-dma.txt
rename to Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
diff --git a/Documentation/devicetree/bindings/mfd/bcm590xx.txt b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/bcm590xx.txt
rename to Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt
diff --git a/Documentation/devicetree/bindings/mips/brcm/bcm3384-intc.txt b/Documentation/devicetree/bindings/mips/brcm/brcm,bcm3384-intc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mips/brcm/bcm3384-intc.txt
rename to Documentation/devicetree/bindings/mips/brcm/brcm,bcm3384-intc.txt
diff --git a/Documentation/devicetree/bindings/mips/brcm/bmips.txt b/Documentation/devicetree/bindings/mips/brcm/brcm,bmips.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mips/brcm/bmips.txt
rename to Documentation/devicetree/bindings/mips/brcm/brcm,bmips.txt
diff --git a/Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt b/Documentation/devicetree/bindings/mips/brcm/brcm,cm-dsl.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt
rename to Documentation/devicetree/bindings/mips/brcm/brcm,cm-dsl.txt
diff --git a/Documentation/devicetree/bindings/net/broadcom-sf2.txt b/Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt
similarity index 100%
rename from Documentation/devicetree/bindings/net/broadcom-sf2.txt
rename to Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt
diff --git a/Documentation/devicetree/bindings/net/broadcom-bcmgenet.txt b/Documentation/devicetree/bindings/net/brcm,bcmgenet.txt
similarity index 100%
rename from Documentation/devicetree/bindings/net/broadcom-bcmgenet.txt
rename to Documentation/devicetree/bindings/net/brcm,bcmgenet.txt
diff --git a/Documentation/devicetree/bindings/net/broadcom-systemport.txt b/Documentation/devicetree/bindings/net/brcm,systemport.txt
similarity index 100%
rename from Documentation/devicetree/bindings/net/broadcom-systemport.txt
rename to Documentation/devicetree/bindings/net/brcm,systemport.txt
diff --git a/Documentation/devicetree/bindings/net/broadcom-mdio-unimac.txt b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
similarity index 100%
rename from Documentation/devicetree/bindings/net/broadcom-mdio-unimac.txt
rename to Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
diff --git a/Documentation/devicetree/bindings/phy/bcm-phy.txt b/Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.txt
similarity index 100%
rename from Documentation/devicetree/bindings/phy/bcm-phy.txt
rename to Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.txt
diff --git a/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
similarity index 100%
rename from Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
rename to Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm/kona-resetmgr.txt b/Documentation/devicetree/bindings/reset/brcm,bcm21664-resetmgr.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm/kona-resetmgr.txt
rename to Documentation/devicetree/bindings/reset/brcm,bcm21664-resetmgr.txt
diff --git a/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
similarity index 100%
rename from Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
rename to Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
diff --git a/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/bcm2835-i2s.txt
rename to Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt b/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
rename to Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
diff --git a/Documentation/devicetree/bindings/mips/brcm/usb.txt b/Documentation/devicetree/bindings/usb/brcm,bcm3384-usb.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mips/brcm/usb.txt
rename to Documentation/devicetree/bindings/usb/brcm,bcm3384-usb.txt
diff --git a/Documentation/devicetree/bindings/arm/bcm/kona-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/bcm/kona-wdt.txt
rename to Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
-- 
2.3.3

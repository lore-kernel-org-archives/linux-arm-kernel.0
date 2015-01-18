From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 14:26:49 +0100
Subject: [PATCHv2 0/2] dts: AT91 Watchdog, remove property idle halt by default
In-Reply-To: <20150118090820.07856398@bbrezillon>
References: <20150118090820.07856398@bbrezillon>
Message-ID: <1421587611-32708-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change since v1:
  * Apply this change for all impacted SoCs
  * Improved DTS documentation about this property

Sylvain Rochet (2):
  dts: Documentation: AT91 Watchdog, explain what atmel,idle-halt
    property really do
  dts: AT91 Watchdog, remove property idle halt by default

 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 5 +++++
 arch/arm/boot/dts/at91sam9260.dtsi                       | 1 -
 arch/arm/boot/dts/at91sam9263.dtsi                       | 1 -
 arch/arm/boot/dts/at91sam9g45.dtsi                       | 1 -
 arch/arm/boot/dts/at91sam9n12.dtsi                       | 1 -
 arch/arm/boot/dts/at91sam9x5.dtsi                        | 1 -
 arch/arm/boot/dts/sama5d3.dtsi                           | 1 -
 7 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.1.4

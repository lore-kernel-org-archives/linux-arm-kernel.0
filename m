From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 16 Oct 2016 18:21:44 +0200
Subject: [PATCH v2] ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx,
 clear pullup on tx
Message-ID: <20161016162145.26193-1-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
  * While we are at it, remove useless pinctrl comments, as suggested
    by Alexandre.
  * Remove consumption story about the pull-up on a push-pull output
    in the commit message, it does not seem to be the case, or rather
    the contrary, as per
    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/368643.html
    results, the dt must be logical anyway.

Sylvain Rochet (1):
  ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx, clear pullup on tx

 arch/arm/boot/dts/at91rm9200.dtsi  | 4 ++--
 arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9261.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9263.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9n12.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9rl.dtsi  | 4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
 arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
 arch/arm/boot/dts/sama5d4.dtsi     | 4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.9.3

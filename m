From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Mar 2013 15:23:32 +0100
Subject: [PATCH 0/4] ARM: at91: little DT fixes
Message-ID: <cover.1363960549.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some little fixes found while adding device tree boards.
I plan to request a pull on this material early next week.


Nicolas Ferre (4):
  ARM: at91/dt: fix macb node declaration
  ARM: at91/trivial: typos in compatible property
  ARM: at91/trivial: fix model name for SAM9G15-EK
  ARM: at91: remove partial parameter in bootargs for at91sam9x5ek.dtsi

 arch/arm/boot/dts/at91sam9g15.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9g15ek.dts |  2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9g25ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9g35.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9g35ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9x25.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9x25ek.dts | 14 ++++++++++++++
 arch/arm/boot/dts/at91sam9x35.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9x35ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi |  7 +------
 11 files changed, 48 insertions(+), 12 deletions(-)

-- 
1.8.0

From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 May 2015 11:50:52 +0200
Subject: [GIT PULL] at91: dt for 4.2 #3
Message-ID: <1432288252-1017-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Some more DT material for AT91. The USB modifications were part of a series by
Boris and the driver changes had been taken by the USB guys for 4.1, so we are
safe to take the DT changes now.
It is based on at91-dt2 tag that you already have.

Thanks, best regards,

The following changes since commit 8d545f32bd77c10c2ab85fce4ddf1273d325d7d3:

  ARM: at91/dt: sama5d4 xplained: add regulators for v(q)mmc1 supplies (2015-05-19 15:04:55 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt3

for you to fetch changes up to f80737082c210fae8ce15ad5d615da381889d5e9:

  ARM: at91/dt: remove useless usb clock (2015-05-22 11:11:33 +0200)

----------------------------------------------------------------
Third batch of DT changes for 4.2:
- USB host clock refine following changes in drivers
- one little fix for usart pinctrl

----------------------------------------------------------------
Boris Brezillon (3):
      USB: atmel: update DT bindings documentation
      ARM: at91/dt: remove useless uhpck clock references from ehci defintions
      ARM: at91/dt: remove useless usb clock

Nicolas Ferre (1):
      ARM: at91/dt: at91sam9x5: fix usart1 sck pin definition

 .../devicetree/bindings/usb/atmel-usb.txt          | 25 ++++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200.dtsi                  |  4 ++--
 arch/arm/boot/dts/at91sam9260.dtsi                 |  4 ++--
 arch/arm/boot/dts/at91sam9261.dtsi                 |  4 ++--
 arch/arm/boot/dts/at91sam9263.dtsi                 |  4 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  8 +++----
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  5 ++---
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 10 ++++-----
 arch/arm/boot/dts/sama5d3.dtsi                     |  9 ++++----
 arch/arm/boot/dts/sama5d4.dtsi                     |  9 ++++----
 10 files changed, 52 insertions(+), 30 deletions(-)

-- 
Nicolas Ferre

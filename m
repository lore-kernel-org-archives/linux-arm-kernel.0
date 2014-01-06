From: bcm@fixthebug.org (Christian Daudt)
Date: Sun, 5 Jan 2014 23:01:50 -0800
Subject: [GIT PULL] bcm dt updates for 3.14
Message-ID: <CAEPRUYrYNR=63oS91Bq-viYJwXfjtY4+cchY0hMUpaJQAw+NNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:

  Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)

are available in the git repository at:

  git://github.com/broadcom/bcm11351.git tags/bcm-for-3.14-dt

for you to fetch changes up to 30d831156b3a7f249c08cbe457a0d728160db39b:

  clk: bcm281xx: define kona clock binding (2013-12-31 09:08:38 -0800)

----------------------------------------------------------------
Add i2c, usb and clock DT configuration to bcm mobile.

----------------------------------------------------------------
Alex Elder (1):
      clk: bcm281xx: define kona clock binding

Matt Porter (1):
      ARM: dts: add usb udc support to bcm281xx

Tim Kryger (8):
      ARM: dts: bcm28155-ap: Enable all the i2c busses
      ARM: dts: Declare clocks as fixed on bcm11351
      ARM: dts: bcm281xx: Add i2c busses
      ARM: dts: Specify clocks for UARTs on bcm11351
      Documentation: dt: kona-sdhci: Add clocks property
      ARM: dts: Specify clocks for SDHCIs on bcm11351
      Documentation: dt: kona-timer: Add clocks property
      ARM: dts: Specify clocks for timer on bcm11351
 .../devicetree/bindings/arm/bcm/kona-timer.txt     |   7 +-
 .../devicetree/bindings/clock/bcm-kona-clock.txt   |  93 ++++++++++++
 .../devicetree/bindings/mmc/kona-sdhci.txt         |   4 +
 arch/arm/boot/dts/bcm11351-brt.dts                 |   6 +
 arch/arm/boot/dts/bcm11351.dtsi                    | 169 ++++++++++++++++++++-
 arch/arm/boot/dts/bcm28155-ap.dts                  |  28 ++++
 6 files changed, 301 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bcm-kona-clock.txt

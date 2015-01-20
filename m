From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 20 Jan 2015 23:33:59 +0100
Subject: [GIT PULL] ARM: BCM5301X: DT changes for v3.20
Message-ID: <54BED7D7.80207@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

This is a pull request with some dt updates for BCM5301X for 3.20.

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://github.com/hauke/linux.git tags/bcm5301x-dt-2015-01-20

for you to fetch changes up to 5b1864b899d2b591402704dd0f6528c8661f1817:

  ARM: BCM5301X: Add DT for Buffalo WZR-900DHP (2015-01-20 23:23:25 +0100)

----------------------------------------------------------------
bcm5301x-dt-2015-01-20: ARM: BCM5301X: dts updates for 3.20

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

----------------------------------------------------------------
Dan Haab (1):
      ARM: BCM5301X: Add DT for Luxul XWC-1000

Rafa? Mi?ecki (3):
      ARM: BCM5301X: Drop unused poll-interval from gpio-keys
      ARM: BCM5301X: Add LEDs for Buffalo devices
      ARM: BCM5301X: Add DT for Buffalo WZR-900DHP

 arch/arm/boot/dts/Makefile                         |  4 +++-
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 68
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       | 60
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |  1 -
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |  1 -
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |  1 -
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 68
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  | 37
+++++++++++++++++++++++++++++++++++++
 8 files changed, 234 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
 create mode 100644 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts

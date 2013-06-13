From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 21:45:26 -0600
Subject: [GIT PULL 1/2] ARM: bcm2835: device tree updates
Message-ID: <1371095127-23847-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just one patch this time: enable the LED via gpio-leds.

----------------------------------------------------------------

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.11-dt

for you to fetch changes up to 805b4db8076d47a181032a87db8a732fc8d94596:

  ARM: bcm2835: Add Raspberry Pi's ACT LED to DT

----------------------------------------------------------------

Daniel Mack (1):
      ARM: bcm2835: Add Raspberry Pi's ACT LED to DT

 arch/arm/boot/dts/bcm2835-rpi-b.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

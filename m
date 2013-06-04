From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Jun 2013 09:49:58 -0400
Subject: [GIT PULL 1/2] ARM: mvebu: dt changes for v3.11 (round 4)
Message-ID: <20130604134958.GC3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


resending with the Cc: list added, oops.

Olof,

Here's some DT patches I've had in -next for about a week


The following changes since commit 9196024a989ace933d6b17e0a56c847d02d81240:

  arm: kirkwood: openblocks-a6: add support for Init button (2013-05-27 15:35:04 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt-3.11-4

for you to fetch changes up to 33a6675485f27adc182faa856944836e85520fa1:

  ARM: Kirkwood add cpus definition needed by cpufreq driver to dtsi (2013-06-03 16:23:24 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.11 (round 4)

 - kirkwood
    - reshuffle nodes from kirkwood.dtsi to -6281.dtsi, etc
    - add i2c-gpio for km_kirkwood
    - add cpu node so pending cpufreq driver will init

----------------------------------------------------------------
Adam Baker (1):
      ARM: Kirkwood add cpus definition needed by cpufreq driver to dtsi

Valentin Longchamp (2):
      ARM: kirkwood: refactor dtsi to largest common nodes
      ARM: kirkwood: add i2c-gpio controller for km_kirkwood

 arch/arm/boot/dts/kirkwood-6281.dtsi       | 28 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-6282.dtsi       | 28 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts |  7 ++++++
 arch/arm/boot/dts/kirkwood-nsa310.dts      |  1 +
 arch/arm/boot/dts/kirkwood.dtsi            | 40 +++++++++---------------------
 5 files changed, 76 insertions(+), 28 deletions(-)

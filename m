From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 13 Jun 2013 17:24:13 -0400
Subject: [GIT PULL 2/3] ARM: mvebu: dt changes for v3.11 #5
In-Reply-To: <20130613212137.GE31667@titan.lakedaemon.net>
References: <20130613212137.GE31667@titan.lakedaemon.net>
Message-ID: <20130613212413.GF31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 33a6675485f27adc182faa856944836e85520fa1:

  ARM: Kirkwood add cpus definition needed by cpufreq driver to dtsi (2013-06-03 16:23:24 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt-3.11-5

for you to fetch changes up to 918f8f309643978b9e761f39af8962a7388d332d:

  ARM: Kirkwood: ts219: Enable second PCIe port in DT. (2013-06-11 16:02:08 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.11 (round 5)

 - mvebu
    - set aliases for ethernet interfaces
    - PCIe range for armada-xp-db
    - rm unused properties on A370

 - kirkwood
    - assign sheevaplug pinmuxs to correct devices
    - enable second PCIe port for ts219

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: ts219: Enable second PCIe port in DT.

Ezequiel Garcia (1):
      ARM: mvebu: Remove device tree unused properties on A370

Simon Baatz (1):
      arm: kirkwood: sheevaplug: move pinmux configs to the right devices

Thomas Petazzoni (1):
      arm: mvebu: armada-xp-db: ensure PCIe range is specified

Willy Tarreau (1):
      ARM: mvebu: set aliases for ethernet controllers

 arch/arm/boot/dts/armada-370-xp.dtsi              |  9 +++++++--
 arch/arm/boot/dts/armada-370.dtsi                 |  4 ----
 arch/arm/boot/dts/armada-xp-db.dts                |  1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi          |  3 ++-
 arch/arm/boot/dts/armada-xp.dtsi                  |  6 +++++-
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi | 16 ++++++----------
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts   | 21 ++++++++++++---------
 arch/arm/boot/dts/kirkwood-sheevaplug.dts         | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-ts219-6282.dts         |  8 ++++++++
 9 files changed, 49 insertions(+), 37 deletions(-)

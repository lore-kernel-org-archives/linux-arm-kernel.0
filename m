From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 18:54:34 +0000
Subject: [GIT PULL] ARM: tegra: dt2 branch
In-Reply-To: <1337016017-30537-1-git-send-email-swarren@wwwdotorg.org>
References: <1337016017-30537-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201205141854.34331.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2012, Stephen Warren wrote:
> This is some late device tree additions and cleanup for Tegra.

Hi Stephen,

The log you sent there does not match what I got. These are the changes I got
from pulling your tree:

      ARM: dt: tegra: invert status=disable vs status=okay
      ARM: dt: tegra: consistent basic property ordering
      ARM: dt: tegra: sort nodes based on bus order
      ARM: dt: tegra: remove duplicate device_type property
      ARM: dt: tegra: consistenly use lower-case for hex constants
      ARM: dt: tegra: format regs properties consistently
      ARM: dt: tegra: gpio comment cleanup
      ARM: dt: tegra: remove unnecessary unit addresses
      ARM: dt: tegra: whitespace cleanup
      ARM: dt: tegra cardhu: fix typo in SDHCI node name
      ARM: dt: tegra: cardhu: register core regulator tps62361
      ARM: dt: tegra30.dtsi: Add SMMU node
      ARM: dt: tegra20.dtsi: Add GART node
      ARM: dt: tegra30.dtsi: Add Memory Controller(MC) nodes
      ARM: dt: tegra20.dtsi: Add Memory Controller(MC) nodes
      ARM: dt: tegra: Add device tree support for AHB

 arch/arm/boot/dts/tegra-cardhu.dts    |   77 +++++++-----------
 arch/arm/boot/dts/tegra-harmony.dts   |  100 +++++++++++------------
 arch/arm/boot/dts/tegra-paz00.dts     |  112 ++++++++++++-------------
 arch/arm/boot/dts/tegra-seaboard.dts  |  176 +++++++++++++++++++---------------------
 arch/arm/boot/dts/tegra-trimslice.dts |   71 +++++++---------
 arch/arm/boot/dts/tegra-ventana.dts   |   90 ++++++++++-----------
 arch/arm/boot/dts/tegra20.dtsi        |  275 +++++++++++++++++++++++++++++++++++---------------------------
 arch/arm/boot/dts/tegra30.dtsi        |  292 ++++++++++++++++++++++++++++++++++++++----------------------------
 8 files changed, 605 insertions(+), 588 deletions(-)

I can't see anything wrong with your commits but please check again that it all makes
sense and let me know if I should really pull this version.

	Arnd

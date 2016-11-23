From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 23 Nov 2016 09:59:16 +0100
Subject: [GIT PULL] STi DT fix for v4.9-rcs round 2
Message-ID: <d109e729-0d50-40ac-ceeb-16d88a7a3e74@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Please consider this second round for inclusion into the v4.9-rc.

The following changes since commit 5bf7b6e86f29f064979d7b3e6dd21c5dd1feb855:

  ARM: dts: STiH410-b2260: Fix typo in spi0 chipselect definition (2016-11-15 11:29:25 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git sti-dt-for-v4.9-rc-round2

for you to fetch changes up to 86b4522d19329b3bf9c05722f217568b803439f7:

  ARM: dts: STiH407-family: fix i2c nodes (2016-11-23 09:09:03 +0100)

----------------------------------------------------------------
STi DT fix:

The I2C nodes are missing #address-cells and #size-cells.
This is causing warning at device tree compilation when
some I2C device sub-nodes are defined.

----------------------------------------------------------------
Loic Pallardy (1):
      ARM: dts: STiH407-family: fix i2c nodes

 arch/arm/boot/dts/stih407-family.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 17:35:10 +0200
Subject: [GIT PULL] ARM: mvebu: drivers for v4.9 (#1)
Message-ID: <87a8fabikx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for drivers for mvebu for v4.9.

Gregory

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-4.9-1

for you to fetch changes up to e8f3f276d974b55554cbd47af024b29a576b0e59:

  pinctrl: mvebu: orion5x: Generalise mv88f5181l support for 88f5181 (2016-09-14 16:02:45 +0200)

----------------------------------------------------------------
mvebu drivers for 4.9 (part 1)

- Add pinctrl and clk support for the Orion5x SoC mv88f5181 variant

----------------------------------------------------------------
Jamie Lentin (2):
      clk: mvebu: Add clk support for the orion5x SoC mv88f5181
      pinctrl: mvebu: orion5x: Generalise mv88f5181l support for 88f5181

 .../devicetree/bindings/clock/mvebu-core-clock.txt |  1 +
 .../bindings/pinctrl/marvell,orion-pinctrl.txt     |  4 +-
 drivers/clk/mvebu/orion.c                          | 70 ++++++++++++++++++++++
 drivers/pinctrl/mvebu/pinctrl-orion.c              | 23 +++----
 4 files changed, 86 insertions(+), 12 deletions(-)

From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 16:21:10 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.12
Message-ID: <20130814202109.GI13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Praise to $diety, this one is easy ;-)


The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/defconfig-3.12

for you to fetch changes up to 697004aebfd847374f401dc852d2f2e107aa3096:

  ARM: dove: update dove_defconfig with SI5351, PCI, and xHCI (2013-08-12 19:57:38 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.12

 - kirkwood: add i2c devices, ext4, r8169
 - mvebu: gpio-keys, input event
 - dove: SI5351, PCI, xHCI

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: update defconfig for used i2c devices, EXT4 FS, r8169

Sebastian Hesselbarth (1):
      ARM: dove: update dove_defconfig with SI5351, PCI, and xHCI

Thomas Petazzoni (1):
      ARM: mvebu: add gpio-keys and input event support in defconfig

 arch/arm/configs/dove_defconfig     |  4 ++++
 arch/arm/configs/kirkwood_defconfig | 10 +++++++++-
 arch/arm/configs/mvebu_defconfig    |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

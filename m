From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 26 Nov 2014 00:38:19 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.19 (round 3)
Message-ID: <20141126053819.GX22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folks,

This is the last round of DT changes.  I kept it out separate because I
just applied the patches tonight.  It also has a dependency on Kishon's
guaranteed immutable branch tag, phy-dt-header.  Which, unfortunately,
pulls in -rc4.  Hopefully this isn't a surprise to you. :)

This is an incremental pull request from a random position on the
mvebu/dt branch up to tags/mvebu-dt-3.19-3.

Please pull.

thx,

Jason.


The following changes since commit b3d6cfd09184dcea17f7d8e29c71fafe58bb5f00:

  Merge tag 'tags/phy-dt-header' into mvebu/dt-usb_phy (2014-11-26 03:48:18 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-usb-phy-3.19-3

for you to fetch changes up to 623394def7ef023aa44e338de680222cdc93c4a5:

  ARM: mvebu: add PHY support to the dts for the USB controllers on Armada 375 (2014-11-26 03:55:43 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.19 (round 3)

 - Armada 375
    - Add PHY and USB cluster controller support

----------------------------------------------------------------
Gregory CLEMENT (2):
      ARM: mvebu: add Device Tree description of USB cluster controller on Armada 375
      ARM: mvebu: add PHY support to the dts for the USB controllers on Armada 375

 arch/arm/boot/dts/armada-375.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

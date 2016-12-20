From: romain.perier@free-electrons.com (Romain Perier)
Date: Tue, 20 Dec 2016 09:51:35 +0100
Subject: [PATCH v2 0/3] Add support for the ethernet switch on the ESPRESSObin
Message-ID: <20161220085138.3998-1-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This set of patches adds support for the Marvell ethernet switch 88E6341.
It also add the devicetree definition of this switch to the DT board.

Romain Perier (3):
  net: dsa: mv88e6xxx: Don't forbid MDIO I/Os for PHY addr >=
    num_of_ports
  net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341/88E6141
  arm64: dts: marvell: Add ethernet switch definition for the
    ESPRESSObin

 .../boot/dts/marvell/armada-3720-espressobin.dts   | 67 ++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.c                   | 48 ++++++++++++++--
 drivers/net/dsa/mv88e6xxx/mv88e6xxx.h              |  4 +-
 3 files changed, 112 insertions(+), 7 deletions(-)

-- 
2.9.3

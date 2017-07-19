From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 19 Jul 2017 17:29:07 +0200
Subject: [PATCH 0/2] Atheros 803x PHY RGMII clock delays
Message-ID: <b332dc3e-4478-e34b-2b3f-226aad8a11d4@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches address the quirks of the Atheros PHY, with respect
to RGMII RX and TX clock delays.

Once the PHY driver is fixed, the second patch fixes the ethernet
controller used on tango boards.

Marc Gonzalez (2):
  net: phy: at803x: Fix RGMII RX and TX clock delays setup
  net: ethernet: nb8800: Fix RGMII TX clock delay setup

 drivers/net/ethernet/aurora/nb8800.c |  8 +++++---
 drivers/net/phy/at803x.c             | 32 ++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.11.0

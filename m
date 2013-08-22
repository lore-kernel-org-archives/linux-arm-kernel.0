From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 22 Aug 2013 17:56:20 +0200
Subject: [PATCH 0/2] net/cadence/macb: add support for dt phy definition
Message-ID: <1377186980-21902-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for ethernet phy definition using device
tree.

This may help in moving some at91 boards to dt (some of them define an
interrupt pin).

Tested on samad31ek.

Best Regards,
Boris

Boris BREZILLON (2):
  net/cadence/macb: add support for dt phy definition
  ARM: at91/dt: define phy available on sama5d3 mother board

 arch/arm/boot/dts/sama5d3xmb.dtsi   |    8 +++++++
 drivers/net/ethernet/cadence/macb.c |   41 +++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 7 deletions(-)

-- 
1.7.9.5

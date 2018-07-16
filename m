From: nm@ti.com (Nishanth Menon)
Date: Mon, 16 Jul 2018 12:13:26 -0500
Subject: [PATCH V2 0/2] firmware: ti_sci: Add host-id as an optional parameter
Message-ID: <20180716171328.11674-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please find attached series to enable host-id as an optional dt property.

This is a minor update to V1 -> Mostly to pick up Greet's feedback and Rob's Ack.

V1: https://patchwork.ozlabs.org/cover/931822/

The series is based on v4.18-rc1 and is available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-tisci

Consolidated all patches (including all series) are available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ

Full Boot log (integrated of all series for AM654) is available here:
   https://pastebin.ubuntu.com/p/bBFmnzYtCd/

Nishanth Menon (2):
  Documentation: dt: keystone: ti-sci: Add optional host-id parameter
  firmware: ti_sci: Provide host-id as an optional dt parameter

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
 drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.15.1

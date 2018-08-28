From: nm@ti.com (Nishanth Menon)
Date: Mon, 27 Aug 2018 19:59:22 -0500
Subject: [PATCH V3 0/2] firmware: ti_sci: Add host-id as an optional parameter
Message-ID: <20180828005924.13092-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

This is the rebase to v4.19-rc1 and repost of the patch series [1]
Please find attached series to enable host-id as an optional dt property.

[1] https://patchwork.ozlabs.org/cover/931822/

No Functional changes. Will be great if we can get this in rc cycle,
but, will defer to you.

Nishanth Menon (2):
  Documentation: dt: keystone: ti-sci: Add optional host-id parameter
  firmware: ti_sci: Provide host-id as an optional dt parameter

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
 drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.15.1

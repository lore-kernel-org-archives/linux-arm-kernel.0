From: ddaney.cavm@gmail.com (David Daney)
Date: Mon, 10 Aug 2015 17:58:35 -0700
Subject: [PATCH v2 0/2] net: thunder: Add ACPI support.
Message-ID: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Change from v1:  Drop PHY binding part, use fwnode_property* APIs.

The first patch (1/2) rearranges the existing code a little with no
functional change to get ready for the second.  The second (2/2) does
the actual work of adding support to extract the needed information
from the ACPI tables.

David Daney (1):
  net, thunder, bgx: Add support to get MAC address from ACPI.

Robert Richter (1):
  net: thunder: Factor out DT specific code in BGX

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 134 +++++++++++++++++++---
 1 file changed, 120 insertions(+), 14 deletions(-)

-- 
1.9.1

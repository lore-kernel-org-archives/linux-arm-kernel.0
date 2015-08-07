From: ddaney.cavm@gmail.com (David Daney)
Date: Thu,  6 Aug 2015 17:33:08 -0700
Subject: [PATCH 0/2] net: thunder: Add ACPI support.
Message-ID: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Hook up PHYs, and get MAC address from ACPI for the thunder driver.

The first patch (1/2) rearranges the existing code a little with no
functional change to get ready for the second.  The second (2/2) does
the actual work of adding support to extract the needed information
from the ACPI tables.

David Daney (1):
  net, thunder, bgx: Add support for ACPI binding.

Robert Richter (1):
  net: thunder: Factor out DT specific code in BGX

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 183 ++++++++++++++++++++--
 1 file changed, 169 insertions(+), 14 deletions(-)

-- 
1.9.1

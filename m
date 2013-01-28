From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 29 Jan 2013 01:42:23 +0530
Subject: [PATCH 0/2] Add CPSW VLAN Support
Message-ID: <1359403945-28585-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPSW is capable of filtering VLAN packets in hardware. This patch series
implements VLAN support to CPSW driver.
This patch series is tested on net-next with AM335x EVM with ping test.


Mugunthan V N (2):
  drivers: net: cpsw: Add helper functions for VLAN ALE implementation
  drivers: net:ethernet: cpsw: add support for VLAN

 Documentation/devicetree/bindings/net/cpsw.txt |    2 +
 drivers/net/ethernet/ti/cpsw.c                 |  108 ++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.c             |  172 +++++++++++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.h             |   11 ++
 include/linux/platform_data/cpsw.h             |    1 +
 5 files changed, 288 insertions(+), 6 deletions(-)

-- 
1.7.9.5

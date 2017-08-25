From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 25 Aug 2017 15:23:28 -0700
Subject: [PATCH 0/2] drivers: net: xgene: Misc bug fixes
Message-ID: <1503699810-12803-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set,

     1. Adds call to PHY disconnect in the case of error
     2. Cleans up all outstanding TX descriptors when the driver is
	being rmmod'd

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (1):
  drivers: net: xgene: Clean up all outstanding tx descriptors

Quan Nguyen (1):
  drivers: net: xgene: Correct probe sequence handling

 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 147 ++++++++++++++++-------
 1 file changed, 102 insertions(+), 45 deletions(-)

-- 
2.7.4

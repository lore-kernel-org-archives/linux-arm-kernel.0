From: cov@codeaurora.org (Christopher Covington)
Date: Fri,  9 Dec 2016 16:53:05 -0500
Subject: [PATCH] net: mlx5: Fix Kconfig help text
Message-ID: <20161209215306.721-1-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the following commit, Infiniband and Ethernet have not been
mutually exclusive.

Fixes: 4aa17b28 mlx5: Enable mutual support for IB and Ethernet

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index aae4688..521cfdb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -18,8 +18,6 @@ config MLX5_CORE_EN
 	default n
 	---help---
 	  Ethernet support in Mellanox Technologies ConnectX-4 NIC.
-	  Ethernet and Infiniband support in ConnectX-4 are currently mutually
-	  exclusive.
 
 config MLX5_CORE_EN_DCB
 	bool "Data Center Bridging (DCB) Support"
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.

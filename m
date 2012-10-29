From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 29 Oct 2012 19:45:13 +0100
Subject: [PATCH net-next V3 03/10] cpsw: add missing fields to the CPSW_SS
 register bank.
In-Reply-To: <cover.1351535536.git.richardcochran@gmail.com>
References: <cover.1351535536.git.richardcochran@gmail.com>
Message-ID: <0c002e3d9e0ff396d380148df48b997355b9a7f8.1351535538.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index e651a2a..b4ca370 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -148,6 +148,14 @@ struct cpsw_ss_regs {
 	u32	soft_reset;
 	u32	stat_port_en;
 	u32	ptype;
+	u32	soft_idle;
+	u32	thru_rate;
+	u32	gap_thresh;
+	u32	tx_start_wds;
+	u32	flow_control;
+	u32	vlan_ltype;
+	u32	ts_ltype;
+	u32	dlr_ltype;
 };
 
 struct cpsw_slave_regs {
-- 
1.7.2.5

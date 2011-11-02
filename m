From: davidb@codeaurora.org (David Brown)
Date: Wed,  2 Nov 2011 11:36:11 -0700
Subject: [RFC PATCH 14/34] msm: proc_comm: Add CLKCTL_RPC_SRC_REQUEST
In-Reply-To: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1320258991-22325-15-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

This proc_comm command is used to vote for crystal oscillators on
7x30/8x55 variants.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/proc_comm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/proc_comm.h b/arch/arm/mach-msm/proc_comm.h
index 12da4ca..e2f2d5a 100644
--- a/arch/arm/mach-msm/proc_comm.h
+++ b/arch/arm/mach-msm/proc_comm.h
@@ -137,6 +137,7 @@ enum {
 	PCOM_CLKCTL_RPC_RAIL_DISABLE,
 	PCOM_CLKCTL_RPC_RAIL_CONTROL,
 	PCOM_CLKCTL_RPC_MIN_MSMC1,
+	PCOM_CLKCTL_RPC_SRC_REQUEST,
 	PCOM_NUM_CMDS,
 };
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

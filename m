From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 17:46:54 -0700
Subject: [PATCH 1/5] clk: ti: am335x/am4372: Add tbclk to pwm node
In-Reply-To: <1457380318-15452-2-git-send-email-fcooper@ti.com>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
 <1457380318-15452-2-git-send-email-fcooper@ti.com>
Message-ID: <20160416004654.GP26353@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07, Franklin S Cooper Jr wrote:
> Add tblck to the pwm nodes. This insures that the ehrpwm driver has access
> to the time-based clk.
> 
> Do not remove similar entries for ehrpwm node. Later patches will switch
> from using ehrpwm node name to pwm. But to maintain ABI compatibility we
> shouldn't remove the old entries.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

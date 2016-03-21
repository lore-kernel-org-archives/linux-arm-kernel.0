From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 21 Mar 2016 11:43:18 -0700
Subject: [PATCH v3 1/3] clk: ti: am335x/am4372: Add tbclk to pwm node
In-Reply-To: <1458263723-25770-2-git-send-email-fcooper@ti.com>
References: <1458263723-25770-1-git-send-email-fcooper@ti.com>
 <1458263723-25770-2-git-send-email-fcooper@ti.com>
Message-ID: <20160321184318.GS25972@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17, Franklin S Cooper Jr wrote:
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

Are there any plans to get off these DT_CLK entries entirely?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:19:51 -0800
Subject: [PATCH] clk: cs2000: add Suspend/Redume feature
In-Reply-To: <87pojvxve9.wl%kuninori.morimoto.gx@renesas.com>
References: <87pojvxve9.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20170121001951.GK20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10, Kuninori Morimoto wrote:
> From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> 
> CS2000 needs re-setup when redume, otherwise, it can't
> handle correct clock rate.
> 
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> [Kuninori: cleanup original patch]
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

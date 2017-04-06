From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 6 Apr 2017 16:11:52 -0700
Subject: [PATCH] cs-2000-cp: keep Reserved bit on each register
In-Reply-To: <87y3vfxw3q.wl%kuninori.morimoto.gx@renesas.com>
References: <87y3vfxw3q.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20170406231152.GT7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thus CS2000 datasheet is indicating below, this patch
> follows it.
> 
> WARNING: All "Reserved" registers must maintain their default
>          state to ensure proper functional operation.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

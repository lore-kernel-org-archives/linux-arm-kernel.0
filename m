From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Jul 2017 17:36:50 -0700
Subject: [PATCH 05/10] clk: sunxi-ng: h3: gate then ungate PLL CPU clk
 after rate change
In-Reply-To: <20170723102749.17323-6-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-6-icenowy@aosc.io>
Message-ID: <20170726003650.GH2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23, Icenowy Zheng wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> This patch utilizes the new PLL clk notifier to gate then ungate the
> PLL CPU clock after rate changes. This should prevent any system hangs
> resulting from cpufreq changes to the clk.
> 
> Reported-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

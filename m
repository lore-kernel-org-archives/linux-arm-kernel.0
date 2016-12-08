From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Dec 2016 14:08:24 -0800
Subject: [PATCH 0/3] clkdev: add devm_get_clk_from_child()
In-Reply-To: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20161208220824.GM5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> This is v5 of "clkdev: add devm_of_clk_get()", but new series.
> I hope my understanding was correct with your idea.

Yes this looks good. Given that we're so close to the merge
window, perhaps I should just merge the first patch into clk-next
and then it will be ready for anyone who wants to use it? The
sound patches can be left up to others to handle.

> 
> Kuninori Morimoto (3):
>   1) clkdev: add devm_get_clk_from_child()
>   2) ASoC: simple-card: use devm_get_clk_from_child()
>   3) ASoC: simple-card-utils: enable clocks/clock-names/clock-ranges

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

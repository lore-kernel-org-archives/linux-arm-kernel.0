From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 23 Mar 2017 09:37:11 +0800
Subject: [PATCH 1/3] clk: zte: set CLK_SET_RATE_PARENT for a few zx296718
 clocks
In-Reply-To: <1490085503-15713-2-git-send-email-shawnguo@kernel.org>
References: <1490085503-15713-1-git-send-email-shawnguo@kernel.org>
 <1490085503-15713-2-git-send-email-shawnguo@kernel.org>
Message-ID: <CABymUCMPR3eW1Ubry6y6Hz5DpnBf7+N3bHFnqqzonp5BgJDoWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-03-21 16:38 GMT+08:00 Shawn Guo <shawnguo@kernel.org>:
> From: Shawn Guo <shawn.guo@linaro.org>
>
> To support VOU VGA display driver with different modes, we need to set
> flag for a few clocks, so that clk_set_rate() call in VOU driver can get
> VGA device desired pixel rate.
>
> While at it, the divider between pll_vga and clk_vga gets corrected, as
> it's 1:1 instead of 1:2.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Jun Nie <jun.nie@linaro.org>

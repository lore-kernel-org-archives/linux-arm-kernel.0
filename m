From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 May 2016 11:04:03 -0700
Subject: [GIT PULL] i.MX clock updates for 4.7, take 2
In-Reply-To: <20160503134356.GO5874@tiger>
References: <20160503134356.GO5874@tiger>
Message-ID: <20160506180403.GX3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03, Shawn Guo wrote:
> The following changes since commit 69c542e8022ca53c5fee664548163809eb1777c3:
> 
>   clk: imx: vf610: fix whitespace in vf610-clock.h (2016-04-12 09:31:08 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-4.7-2
> 
> for you to fetch changes up to 92a847e3609a8d00bcbe8bdfacbcbbca03135410:
> 
>   clk: imx7d: fix ahb clock mux 1 (2016-05-03 20:35:38 +0800)
> 
> ----------------------------------------------------------------
> The i.MX clock updates for 4.7, take 2:
>  - Update clk-pllv3 driver to get it return correct frequency for
>    Ethernet PLL on i.MX7D.
>  - Correct ahb clock mux settings for i.MX7D per latest hardware
>    document.
> 

Thanks. Pulled into clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

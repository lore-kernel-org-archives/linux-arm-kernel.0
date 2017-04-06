From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 6 Apr 2017 16:10:03 -0700
Subject: [GIT PULL] Allwinner clock fixes for 4.11, bis
In-Reply-To: <20170406074121.tkivdvghbr27tr54@lukather>
References: <20170406074121.tkivdvghbr27tr54@lukather>
Message-ID: <20170406231003.GS7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06, Maxime Ripard wrote:
> Hi Mike, Stephen,
> 
> Please pull the following changes for one of the 4.11-rc's
> 
> Thanks!
> Maxime
> 
> The following changes since commit b467e08a15563dede0d37d3233baa24fb97a7310:
> 
>   clk: sunxi-ng: fix recalc_rate formula of NKMP clocks (2017-03-20 10:34:05 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.11-2
> 
> for you to fetch changes up to d054a839a0986136374d49f9f9fbc264abae9c4c:
> 
>   clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER (2017-03-27 13:37:05 +0200)
> 
> ----------------------------------------------------------------
> Allwinner clock fixes for 4.11, bis
> 
> A few patches to fix a build error and a few minor typos and bugs in the
> sunxi-ng code
> 
> ----------------------------------------------------------------
> Chen-Yu Tsai (3):
>       clk: sunxi-ng: use 1 as fallback for minimum multiplier
>       clk: sunxi-ng: Fix round_rate/set_rate multiplier minimum mismatch
>       clk: sunxi-ng: a80: Fix audio PLL comment not matching actual code
> 
> Tobias Regnery (1):
>       clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER
> 

Two of these are fixes for regressions in v4.10? Why are these
critical for the v4.11 release? The comment patch is totally
bogus, it's not fixing any sort of regression that is causing
problems for people so I'm not sure why it was put into this pull
request. Am I right in assuming that the only real patch we need
out of here is the last one for the build error from randconfigs?
If so I can cherry-pick that from the branch into fixes and the
rest can go the next merge window.

Not pulling for now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

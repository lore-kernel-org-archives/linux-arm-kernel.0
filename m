From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 May 2016 11:02:17 -0700
Subject: [GIT PULL] i.MX clock fixes for 4.6, take 2
In-Reply-To: <20160503133605.GN5874@tiger>
References: <20160503133605.GN5874@tiger>
Message-ID: <20160506180217.GW3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03, Shawn Guo wrote:
> The following changes since commit 7196c52c9377df0175b510ff5896bda524f7345e:
> 
>   clk: imx6q: fix typo in CAN clock definition (2016-04-13 15:27:15 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-fixes-4.6-2
> 
> for you to fetch changes up to 3397c2c45b1b6f54834dfeae30a73046f33ca943:
> 
>   ARM: dts: imx35: restore existing used clock enumeration (2016-04-18 12:37:21 +0800)
> 
> ----------------------------------------------------------------
> The i.MX clock fixes for 4.6, take 2:
>  - Fix the commit 3713e3f5e927 ("clk: imx35: define two clocks for rtc")
>    which messed up the clock enumeration when adding new clock.

This commit wasn't introduced in this merge window, so I'm going
to pull this into clk-next unless you have some justification.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

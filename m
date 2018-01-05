From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 22:59:16 -0800
Subject: [GIT PULL 1/4] soc changes for omaps for v4.16, part 2
In-Reply-To: <pull-1513966338-859035@atomide.com>
References: <pull-1513966338-859035@atomide.com>
Message-ID: <20180105065916.snklnojvp5tshpvl@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 10:14:24AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit fdf3632938a646c13f7407f2f8c33ff81eed9c76:
> 
>   Merge branch '4.15-rc1-clkctrl-mach-omap2' of https://github.com/t-kristo/linux-pm into omap-for-v4.16/soc (2017-12-11 07:46:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/soc-pt2-signed
> 
> for you to fetch changes up to 234c91d4a350835df8362f6bc968ccf052c60d58:
> 
>   ARM: OMAP2+: dra762: Register package specific hwmod (2017-12-21 07:05:15 -0800)
> 
> ----------------------------------------------------------------
> Second set of SoC changes for omaps for v4.16 merge window
> 
> We can now drop some more of legacy platform data for omap3 as
> it's been booting in device tree only mode for quite a while now.
> This clock related data is coming from device tree configured
> clocks now.
> 
> The other changes add support for detecting new dra762 SoC variant.
> 
> ----------------------------------------------------------------
> Lokesh Vutla (2):
>       ARM: OMAP2+: dra762: Add support for device package identification
>       ARM: OMAP2+: dra762: Register package specific hwmod
> 
> Tony Lindgren (1):
>       ARM: OMAP2+: Drop unused legacy data for prcm_reg_id and module_bit

Nice cleanup. Merged. It had a conflict with an earlier fixes branch, please
double-check my resolution.


-Olof

From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 1 May 2012 19:47:45 +0800
Subject: [GIT PULL] ARM: spear-soc clock updates for 3.5
In-Reply-To: <CAOh2x=n11TXfKp3HkEPFTeFi2qO7tKmedSL7zPeU842-+tu47w@mail.gmail.com>
References: <CAOh2x=n11TXfKp3HkEPFTeFi2qO7tKmedSL7zPeU842-+tu47w@mail.gmail.com>
Message-ID: <20120501114743.GD2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 09:38:43PM +0530, viresh kumar wrote:
> Hi Arnd/Olof,
> 
> This is pull request for SPEAr common clk framework updates. It had dependency
> on spear/dt and spear/pinctrl for applying patches, and so i created a merge
> of v3.4-rc5 with those branches.
> 
> Also, it has compilation dependencies with:
> - Mike's clk-next branch
> - Russell's: CLKDEV: Add helper routines to allocate and add clkdevs for ...
> 
> I have added Reviewed-by from Mike on these patches.
> 
> The following changes since commit 507f3bb673bf25ff0345986c72609debacdcee60:
> 
>   Merge branch 'spear/dt'; branch 'spear/pinctrl' into v3.4-rc5
> (2012-04-30 13:30:19 +0530)
> 
> are available in the git repository at:
> 
> 
>   git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-clk
> 
> for you to fetch changes up to 9e1a2a12e55a9d8da21810cab91b91eb8f27be35:
> 
>   SPEAr: Switch to common clock framework (2012-04-30 13:36:13 +0530)
> 
> ----------------------------------------------------------------
> Sascha Hauer (1):
>       clk: add a fixed factor clock
> 
I think it makes more sense to have this patch picked up by Mike, so
that other platform porting do not have to depend on spear-clk branch.

> Viresh Kumar (6):
>       SPEAr: clk: Add VCO-PLL Synthesizer clock
>       SPEAr: clk: Add Auxiliary Synthesizer clock
>       SPEAr: clk: Add Fractional Synthesizer clock
>       SPEAr: clk: Add General Purpose Timer Synthesizer clock
>       SPEAr: Call clk_prepare() before calling clk_enable
>       SPEAr: Switch to common clock framework
> 

-- 
Regards,
Shawn

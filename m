From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 15:01:32 +0100
Subject: [GIT PULL v2] ARM: imx: soc updates for 3.19
In-Reply-To: <20141123083658.GF11253@dragon>
References: <20141123083658.GF11253@dragon>
Message-ID: <201411281501.32824.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 November 2014, Shawn Guo wrote:
> The i.MX SoC update for 3.19:
>  - Update i.MX6 suspend code to check DDR instead of CPU type, as the
>    difference we need to handle is between LPDDR2 and DDR3, not SoCs.
>  - Set anatop properly for LPDDR2 in DSM mode
>  - Add support for new SoC LS1021A which integrates dual Cortex-A7
>  - Add ENET initialization for i.MX6SX platform
>  - Add cpufreq support for i.MX53 platform
>  - Add a SNVS based poweroff driver for i.MX6 platforms
>  - Use ARM  Global Timer as clocksource on VF610
> 
> Note: the change set is built on top of tag imx-fixes-3.18-2 to resolve
> a conflict on file arch/arm/mach-imx/clk-vf610.c.
> 

Pulled into next/soc, thanks!

	Arnd

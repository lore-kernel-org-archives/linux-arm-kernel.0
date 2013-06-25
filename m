From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 25 Jun 2013 17:03:15 +0200
Subject: [PATCHv3 0/9] ARM: OMAP4 clock data conversion to DT
In-Reply-To: <1372163913-16566-1-git-send-email-t-kristo@ti.com>
References: <1372163913-16566-1-git-send-email-t-kristo@ti.com>
Message-ID: <51C9B133.7040607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/25/2013 02:38 PM, Tero Kristo wrote:
> Hi,
> 
> Changes compared to previous version:
> 
> PATCH 2 - removed some unnecessary headers + module defs
>         - added Mike under copyright
> PATCH 4 - fixed the copyright in the header file
> PATCH 8 - removed a few incorrect comments from the data file
>         - moved /include/ for the clock DT file under omap4 root from
>           soc -> should save some memory based on comments to previous rev
> 
> This set is also rebased on top of Mike's latest clk binding patches (V3.)
> 
> Boot + suspend tested with OMAP4 panda board.
> 
> I also have OMAP5 + DRA7 clock data in the same format, these have been
> tested with trees that have support for these SoCs. I will publish these
> once this set moves forward, or alternatively with next rev of this set
> if requested.
> 
> Test branch also still available (with O4 support only):
>    git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
>    branch:  mainline-3.10-rc6-omap4-dt-clks-v3

I have tested this branch on PandaBoardES. Audio works as it worked before.

To all:
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

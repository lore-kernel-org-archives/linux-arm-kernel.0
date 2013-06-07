From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 7 Jun 2013 14:06:21 +0200
Subject: [PATCH V2 0/4] ARM: dts: omap5: Cleanup and updates for DT files
In-Reply-To: <1370540919-4339-1-git-send-email-r.sricharan@ti.com>
References: <1370540919-4339-1-git-send-email-r.sricharan@ti.com>
Message-ID: <51B1CCBD.5080904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2013 07:48 PM, Sricharan R wrote:
> uevm is the official board supported for OMAP5 soc in the mainline.
> This series renames the board dts file for OMAP5 accordingly and cleans
> up the same. Also a few additional device DT entry updates are done.
> 
> This is on top of the below branch
>     git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
>     for_3.11/dts

Could you update your branch before reposting, I pulled a Makefile fix
for AM5xx that prevents your patches to be applied properly.

Thanks,
Benoit

> 
> Boot tested on omap5-uevm after pulling in the data from below place
>     git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git
>     HWMOD DATA: for_3.11/omap5_data_files
>     CLOCK DATA: out_of_tree/omap5_clk_data
> 
> Dan Murphy (1):
>   ARM: dts: omap5-uevm: Add LED support for uEVM blue LED
> 
> Roger Quadros (1):
>   ARM: dts: omap5-uevm: Add USB Host support
> 
> Sourav Poddar (1):
>   ARM: dts: omap5-uevm: Add uart pinctrl data
> 
> Sricharan R (1):
>   ARM: dts: omap5: Rename omap5-evm to omap5-uevm
> 
>  arch/arm/boot/dts/Makefile       |    2 +-
>  arch/arm/boot/dts/omap5-evm.dts  |  261 --------------------------------
>  arch/arm/boot/dts/omap5-uevm.dts |  311 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi     |   30 ++++
>  4 files changed, 342 insertions(+), 262 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/omap5-evm.dts
>  create mode 100644 arch/arm/boot/dts/omap5-uevm.dts
> 

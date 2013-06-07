From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 7 Jun 2013 16:51:53 +0200
Subject: [PATCH V3 0/4] ARM: dts: omap5: Cleanup and updates for DT files
In-Reply-To: <1370611370-14715-1-git-send-email-r.sricharan@ti.com>
References: <1370611370-14715-1-git-send-email-r.sricharan@ti.com>
Message-ID: <51B1F389.30002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the quick update.

I've just applied the series in my for_3.11/dts branch.

Regards,
Benoit


On 06/07/2013 03:22 PM, Sricharan R wrote:
> uevm is the only official board supported for OMAP5 soc in the mainline.
> This series deprecates the support for existent sevm which will no more
> be supported in mainline and renames the board dts file accordingly.
> Also a few additional device DT entry updates are done.
> 
> This is on top of the below branch
>     git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
>     for_3.11/dts
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
>   ARM: dts: omap5: Make uevm as the official board and deprecate sevm
>     support
> 
>  arch/arm/boot/dts/Makefile       |    2 +-
>  arch/arm/boot/dts/omap5-evm.dts  |  261 --------------------------------
>  arch/arm/boot/dts/omap5-uevm.dts |  311 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi     |   30 ++++
>  4 files changed, 342 insertions(+), 262 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/omap5-evm.dts
>  create mode 100644 arch/arm/boot/dts/omap5-uevm.dts
> 

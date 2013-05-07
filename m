From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Tue, 07 May 2013 11:10:24 +0200
Subject: [PATCH 0/7] mv643xx_eth: device tree bindings
In-Reply-To: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5188C500.8010209@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On 05/06/2013 05:33 PM, Sebastian Hesselbarth wrote:
> This patch set picks up work by Florian Fainelli bringing full DT
> support to mv643xx_eth and Marvell SoCs using it.
> 
> The current patch set drops Florian's device tree conversions for
> Kirkwood, Dove, and Orion5x in favour of split patches for board
> files and board descriptor files.
> 
> Device tree conversion for Dove and Kirkwood is added. Dove has
> been fully tested, while Kirkwood is compile-tested only.
> 
> Florian Fainelli (2):
>   net: mv643xx_eth: add Device Tree bindings
>   net: mv643xx_eth: update Device Tree bindings documentation
> 
> Sebastian Hesselbarth (5):
>   ARM: dove: remove legacy mv643xx_eth setup
>   ARM: dove: add gigabit ethernet and mvmdio device tree nodes
>   ARM: kirkwood: remove legacy mv643xx_eth board setup
>   ARM: kirkwood: add gigabit ethernet and mvmdio device tree nodes
>   ARM: kirkwood: remove legacy clk alias for mv643xx_eth
> 

I have successfully tested these patches on km_kirkwood, you can add my tested-by:

Tested-by: Valentin Longchamp<valentin.longchamp@keymile.com>

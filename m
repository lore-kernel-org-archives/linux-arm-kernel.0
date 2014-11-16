From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 16 Nov 2014 03:20:35 +0100
Subject: [PATCHv1 0/3] arm: mvebu: add Synology DS213j and DS414 .dts files
In-Reply-To: <cover.1416095841.git.arno@natisbad.org>
References: <cover.1416095841.git.arno@natisbad.org>
Message-ID: <20141116022035.GE15870@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Andrew, in this v1, the two .dts files are still separate w/o any common
> .dtsi. I took a quick look it seems there are small differences between
> the two which make me wonder if its worth the trouble:
> 
>  - DS414 fans are not handled by the SoC
>  - various pinctrl variations
>  - a tiny difference in SPI flash partitioning
>  - phy-mode for ethernet interfaces
>  - different comments associated w/ same nodes (e.g. uart1)
>  - etc

O.K, lets wait for the moment. It could be that there is more in
common between different 370 devices, and between different XP
devices, but less in common across 370 and XP.

We can refactor it later when a pattern starts to appear.

>  - Added a comment in the .dts file about the bootloader screwing the kernel
>    if the environment is saved.

Is this well know in the forums? Do you think Synology knows about it?
It would be nice if it was fixed. Maybe not for these products, but
for the next generation.

    Andrew

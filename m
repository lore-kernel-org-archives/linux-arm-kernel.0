From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 09:47:27 +0100
Subject: [GIT PULL] ARM: Kirkwood: new boards for v3.5
In-Reply-To: <20120515032605.GV16338@titan.lakedaemon.net>
References: <20120515032605.GV16338@titan.lakedaemon.net>
Message-ID: <4FB2181F.7010609@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 04:26, Jason Cooper wrote:
> The following changes since commit 36be50515fe2aef61533b516fa2576a2c7fe7664:
>
>    Linux 3.4-rc7 (2012-05-12 18:37:47 -0700)
>
> are available in the git repository at:
>    git://git.infradead.org/users/jcooper/linux.git kirkwood_boards_for_v3.5
>
> Arnaud Patard (3):
>        kirkwood/orion: fix orion_gpio_set_blink
>        orion/kirkwood: create a generic function for gpio led blinking
>        kirkwood: Add iconnect support
>
> Jamie Lentin (4):
>        ARM: kirkwood: Basic support for DNS-320 and DNS-325
>        mtd: Add orion_nand devicetree bindings
>        kirkwood: Allow nand to be configured via. devicetree
>        ARM: kirkwood: Define DNS-320/DNS-325 NAND in fdt
>
> Simon Baatz (1):
>        ARM: kirkwood: Add support for RaidSonic IB-NAS6210/6220 using devicetree
>
>   .../devicetree/bindings/mtd/orion-nand.txt         |   50 ++++
>   arch/arm/boot/dts/kirkwood-dns320.dts              |   64 +++++
>   arch/arm/boot/dts/kirkwood-dns325.dts              |   59 +++++
>   arch/arm/boot/dts/kirkwood-ib62x0.dts              |   44 +++
>   arch/arm/boot/dts/kirkwood-iconnect.dts            |   26 ++

I thought the idea of going to device-tree was to remove the addition
of these? Now instead of .c files we're getting piles of .dts files.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

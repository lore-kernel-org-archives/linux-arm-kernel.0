From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 08:44:49 +0000
Subject: [GIT PULL] ARM: Kirkwood: new boards for v3.5
In-Reply-To: <20120515032605.GV16338@titan.lakedaemon.net>
References: <20120515032605.GV16338@titan.lakedaemon.net>
Message-ID: <201205150844.50031.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Jason Cooper wrote:
> The following changes since commit 36be50515fe2aef61533b516fa2576a2c7fe7664:
> 
>   Linux 3.4-rc7 (2012-05-12 18:37:47 -0700)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/jcooper/linux.git kirkwood_boards_for_v3.5
> 
> Arnaud Patard (3):
>       kirkwood/orion: fix orion_gpio_set_blink
>       orion/kirkwood: create a generic function for gpio led blinking
>       kirkwood: Add iconnect support
> 
> Jamie Lentin (4):
>       ARM: kirkwood: Basic support for DNS-320 and DNS-325
>       mtd: Add orion_nand devicetree bindings
>       kirkwood: Allow nand to be configured via. devicetree
>       ARM: kirkwood: Define DNS-320/DNS-325 NAND in fdt
> 
> Simon Baatz (1):
>       ARM: kirkwood: Add support for RaidSonic IB-NAS6210/6220 using devicetree
 
Please try to be more consistent with the formatting of the subject lines
in the future, the style that everyone else uses is "ARM: kirkwood: ..." for
ARM patches.

Pulled into next/boards, thanks!

	Arnd

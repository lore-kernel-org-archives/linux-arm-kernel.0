From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Apr 2014 00:57:54 -0400
Subject: [GIT PULL] ARM: mvebu: DT fixes-non-critical for v3.15-rc1
In-Reply-To: <20140410140257.GC28159@titan.lakedaemon.net>
References: <20140410140257.GC28159@titan.lakedaemon.net>
Message-ID: <20140417045754.GO28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 10:02:57AM -0400, Jason Cooper wrote:
> All,
> 
> Here are a few small changes I've picked up for the mvebu DT files.
> They've been in -next a few days, and are fairly minimal fixes.
> 
> This branch is based on top of mvebu/dt, specifically,
> tags/mvebu-dt-3.15-5.  As the changes are on top of changes in that
> branch.
> 
> Please pull.

Well, I sent this a little late for v3.15-rc1, so please ignore.  I'm
going to rebase these patches into dt-fixes.

Sorry for the noise.

thx,

Jason.

> The following changes since commit 4de29e636946dbc97586de6136a3c496a55fd5e6:
> 
>   ARM: mvebu: Enable NAND controller in Armada 385-DB (2014-03-13 23:37:17 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-fixes-non-crit-3.15
> 
> for you to fetch changes up to 33faf20b8ebe2770f2d7b52796f5f35eeb87ab6f:
> 
>   ARM: mvebu: ensure the mdio node has a clock reference on Armada 38x (2014-04-07 17:23:56 +0000)
> 
> ----------------------------------------------------------------
> mvebu DT fixes-non-critical (for v3.15-rc1)
> 
>  - kirkwood
>     - add some missing vendor prefixes to keep checkpatch happy
> 
>  - mvebu
>     - add clock ref to mdio node on 370/XP/38x
> 
> ----------------------------------------------------------------
> Andrew Lunn (2):
>       ARM: Kirkwood: Fix Atmel vendor prefix
>       ARM: Kirkwood: DT: Add missing vendor prefix
> 
> Thomas Petazzoni (2):
>       ARM: mvebu: ensure the mdio node has a clock reference on Armada 370/XP
>       ARM: mvebu: ensure the mdio node has a clock reference on Armada 38x
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi           | 1 +
>  arch/arm/boot/dts/armada-38x.dtsi              | 1 +
>  arch/arm/boot/dts/kirkwood-b3.dts              | 2 +-
>  arch/arm/boot/dts/kirkwood-cloudbox.dts        | 2 +-
>  arch/arm/boot/dts/kirkwood-dreamplug.dts       | 2 +-
>  arch/arm/boot/dts/kirkwood-laplug.dts          | 2 +-
>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 2 +-
>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi     | 4 ++--
>  arch/arm/boot/dts/kirkwood-nsa310.dts          | 2 +-
>  arch/arm/boot/dts/kirkwood-nsa310a.dts         | 2 +-
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts   | 2 +-
>  arch/arm/boot/dts/kirkwood-openblocks_a7.dts   | 2 +-
>  12 files changed, 13 insertions(+), 11 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 8 Mar 2013 17:23:17 -0500
Subject: [GIT PULL 3.9] Various fixes for Marvell EBU platforms
In-Reply-To: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130308222317.GV23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 11:23:32AM +0100, Thomas Petazzoni wrote:
> Jason, Andrew, Greg,
> 
> Here are four fixes for Marvell EBU platforms. The first fix is very
> important, without it, all Armada 370/XP platforms are broken. The
> second fix is important as well because it makes the Armada XP GP
> platform actually usable (without it, the platform boots, but no
> network, no XOR, almost nothing works). The two other patches are
> minor DT fixes.
> 
> Thanks.
> 
> The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:
> 
>   Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)
> 
> are available in the git repository at:
> 
>   git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-3.9-fixes-tag
> 
> for you to fetch changes up to 6e025ae424c90febf2d0ad4368f0e5cba8b46f77:
> 
>   arm: mach-orion5x: fix typo in compatible string of a .dts file (2013-03-06 10:32:59 +0100)
> 
> ----------------------------------------------------------------
> Various small fixes for Marvell EBU platforms, intended for 3.9.
> 
> ----------------------------------------------------------------
> Heikki Krogerus (1):
>       arm: mvebu: Reduce reg-io-width with UARTs
> 
> Thomas Petazzoni (3):
>       arm: plat-orion: fix address decoding when > 4GB is used
>       arm: mvebu: fix address-cells in mpic DT node
>       arm: mach-orion5x: fix typo in compatible string of a .dts file
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    5 ++---
>  arch/arm/boot/dts/armada-xp.dtsi                   |    4 ++--
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
>  arch/arm/plat-orion/addr-map.c                     |    7 +++++--
>  4 files changed, 10 insertions(+), 8 deletions(-)

All applied to mvebu/fixes

thx,

Jason.

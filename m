From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 21:53:14 -0700
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.16
In-Reply-To: <20140508151619.GD12708@titan.lakedaemon.net>
References: <20140508151619.GD12708@titan.lakedaemon.net>
Message-ID: <20140520045314.GC18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 11:16:19AM -0400, Jason Cooper wrote:
> guys,
> 
> Here a round of mvebu-devbus changes for v3.16 that add support for
> orion5x.  This is part of the series Thomas did converting orion5x to
> devicetree. sweet!
> 
> These changes have been in -next for over a week.  They are based on
> v3.15-rc1 with mvebu/fixes merged in.  This branch does have a
> dependency on mvebu/fixes as outlined in the tag message.

Hi,

Adding the dependency to the tag isn't really useful -- we don't see that until
the very end of the merge anyway. It's useful in the email though.

> The following changes since commit 1cc9d48145b81e307fab94a5cf6ee66ec2f0de60:
> 
>   ARM: orion5x: fix target ID for crypto SRAM window (2014-04-17 04:52:26 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-3.16
> 
> for you to fetch changes up to 0456d3300edba52e47c6b5582cfe9d87756f5590:
> 
>   memory: mvebu-devbus: add a devbus, keep-config property (2014-04-29 13:17:10 +0000)
> 
> ----------------------------------------------------------------
> mvebu driver changes for v3.16
> 
>  - mvebu-devbus
>     - changes need to add support for the orion5x platform
> 
> Depends:
> 
>   - tags/mvebu-fixes-3.15 in the mvebu/fixes branch for:
> 
>      ce965c3d2e68 memory: mvebu-devbus: fix the conversion of the bus width

Merged into next/drivers. Thanks!


-Olof

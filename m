From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Jan 2018 17:00:28 -0800
Subject: [GIT PULL] Allwinner fixes for 4.15, round 2
In-Reply-To: <20180108084243.GA3261@wens.csie.org>
References: <20180108084243.GA3261@wens.csie.org>
Message-ID: <20180112010028.mpocx3fgpmxj6soo@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 04:42:43PM +0800, Chen-Yu Tsai wrote:
> Hi Arnd, Olof,
> 
> Here's another fix for 4.15. The error was introduced in 4.15-rc1,
> so we'd really like to see it fixed for this release.
> 
> Thanks
> ChenYu
> 
> The following changes since commit eac6a3639decefcc8eb0941dd3cebe79993670ad:
> 
>   ARM: dts: sun8i: a711: Reinstate the PMIC compatible (2017-12-19 09:56:57 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.15-2
> 
> for you to fetch changes up to bdae44705c0d5b751fbd79bc4a169905b25ed335:
> 
>   ARM: dts: sun[47]i: Fix display backend 1 output to TCON0 remote endpoint (2018-01-06 11:21:28 +0800)
> 
> ----------------------------------------------------------------
> Allwinner fixes for 4.15, round 2
> 
> One fix that fixes the display pipeline description in the device tree
> for the A10 and A20 SoCs. This description was introduced in 4.15-rc1
> with a mismatch in the graph remote endpoints, which would likely
> result in the driver misinterpreting how the individual components fit
> together.
> 
> ----------------------------------------------------------------
> Chen-Yu Tsai (1):
>       ARM: dts: sun[47]i: Fix display backend 1 output to TCON0 remote endpoint

Merged, thanks.


-Olof

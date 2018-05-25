From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 14:04:36 -0700
Subject: [GIT PULL] Allwinner fixes for 4.17
In-Reply-To: <20180521115305.6ebm26zqx4a3rftv@flea>
References: <20180521115305.6ebm26zqx4a3rftv@flea>
Message-ID: <20180525210436.g56uh2fiw3zknwu2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 01:53:05PM +0200, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Here are our fixes for the 4.17 release.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi-fixes-for-4.17
> 
> for you to fetch changes up to d89ad4f0b44dde8c5333ef7a5d5824829cc72de3:
> 
>   ARM: sun8i: v3s: fix spelling mistake: "disbaled" -> "disabled" (2018-05-02 14:10:58 +0200)
> 
> ----------------------------------------------------------------
> Allwinner fixes for 4.17
> 
> Here is a bunch of fixes for merge issues, typos and wrong clocks being
> described for simplefb, resulting in non-working displays.

Hi,

This late in the release cycle it'd be nice to have a bit more detail
on why each fix is critical before release, but they're small so I
merged anyway.


-Olof

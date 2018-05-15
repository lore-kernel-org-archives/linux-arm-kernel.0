From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:51:29 -0700
Subject: [GIT PULL 1/4] Rockchip driver updates for 4.18 round 1
In-Reply-To: <2000491.bLgWuj0xar@phil>
References: <2000491.bLgWuj0xar@phil>
Message-ID: <20180515205129.krdwrceinbhs3zcq@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 12:38:09PM +0200, Heiko Stuebner wrote:
> Hi Arnd, Kevin Olof,
> 
> please find below and in the replies the main pull requests for Rockchip
> stuff for 4.18. Depending on timing there may or may not be a second
> round but so far I don't have anything big on the radar.
> 
> The signed tags should explain the individual contents, so please pull.
> 
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-drivers-1
> 
> for you to fetch changes up to 9e59c5f66c624b43c766a9fe3b2430e0e976bf0e:
> 
>   soc: rockchip: power-domain: Fix wrong value when power up pd with writemask (2018-05-14 11:53:26 +0200)
> 
> ----------------------------------------------------------------
> Fix for an issue introduced in 2016 where some powerdomains could only
> be turned off but not on again.

Merged, thanks!


-Olof

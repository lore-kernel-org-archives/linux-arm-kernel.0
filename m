From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 18 Oct 2013 07:05:23 -0700
Subject: [GIT PULL] Rockchip boards for 3.13
In-Reply-To: <201310172138.01672.heiko@sntech.de> ("Heiko =?utf-8?Q?St?=
 =?utf-8?Q?=C3=BCbner=22's?= message
 of "Thu, 17 Oct 2013 21:38:01 +0200")
References: <201310172138.01672.heiko@sntech.de>
Message-ID: <87txgewu70.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner <heiko@sntech.de> writes:

> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
>
>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.13-rockchip-boards
>
> for you to fetch changes up to 0311caed3aa7395fe216dce16222d70a1793554f:
>
>   MAINTAINERS: Add maintainers entry for Rockchip SoCs (2013-10-14 23:19:58 +0200)
>
> ----------------------------------------------------------------
> Support for the RK3188 SoC, basic RK3188 based Radxa Rock board
> and RK3066a based BQ Curie2 tablet.
>
> ----------------------------------------------------------------

This series appears to only have been posted 2 days ago so it seems a
little quick for the pull request.  That being said, there's nothing
earth shattering going on here, and it seems like the pinctrl dependency
changes you mentioned in PATCH 4/5 have been applied by Linus, so....

Since it didn't look like this was already in -next, I broke it up
slightly, putting the MAINTAINERS change into fixes (since we have a
handful of other MAINTAINERS changes there already) and then pulled the
reset into next/boards.

Thanks

Kevin

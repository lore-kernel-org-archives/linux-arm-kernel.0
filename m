From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 14:12:53 +0200
Subject: [GIT PULL] Reset controller changes for v4.8, part 3
In-Reply-To: <1467646412.2224.28.camel@pengutronix.de>
References: <1467646412.2224.28.camel@pengutronix.de>
Message-ID: <4344252.WGCDDndDnK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 4, 2016 5:33:32 PM CEST Philipp Zabel wrote:
> Please consider merging this tag with two new drivers for the Hisilicon
> hi6220 media reset controller and for various TI SYSCON based reset
> controllers. Lee's API changes are already merged into v4.7-rc6 as part
> of commit 4aa34ce3c1ee ("Merge tag 'mfd-fixes-4.7' of
> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd").
> Let me know if I should drop them here.
> 

Including them like you did here is the correct approach, otherwise
we'd get conflicts or broken branches.


> 
> The following changes since commit 79795e20a184ebabf4ae743d1506cc39783caa46:
> 
>   dt-bindings: reset: Add bindings for the Meson SoC Reset Controller (2016-06-01 08:21:12 +0200)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.8-3
> 
> for you to fetch changes up to af3e1629c8d0d26627f3dcc237a6facda8bb1090:
> 
>   Merge branch 'reset/explicit-api' into reset/next (2016-06-29 23:39:52 +0200)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.8, part 3
> 
> - change request API to be more explicit about the difference between
>   exclusive and shared resets (the former guarantee the reset line is
>   asserted immediately when reset_control_assert is called, the latter
>   are refcounted and do not guarantee this).
> - add Hisilicon hi6220 media subsystem reset controller support
> - add TI SYSCON based reset controller support
> 

Merged into next/drivers, thanks!

	Arnd

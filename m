From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 11:52:22 +0200
Subject: [GIT PULL] basic Rockchip support
In-Reply-To: <201306210934.51624.heiko.stuebner@bqreaders.com>
References: <201306210934.51624.heiko.stuebner@bqreaders.com>
Message-ID: <201306211152.22453.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Heiko St?bner wrote:
> If it's not to late, please consider the following. Done on top of the needed
> timer/dw_apb_timer_of branch of arm-soc.
> 
> 
> The following changes since commit 10021488997317d1121505a7ac659124c058efed:
> 
>   clocksource: dw_apb_timer_of: use clocksource_of_init (2013-06-12 13:47:38 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.11-rockchip-basics
> 
> for you to fetch changes up to d63dc0514d56e108cc96e334ca26b538263e52a2:
> 
>   arm: add basic support for Rockchip RK3066a boards (2013-06-21 09:21:02 +0200)
> 
> ----------------------------------------------------------------
> Adds basic support for Rockchip Cortex-A9 SoCs.
> 

Pulled into next/soc, thanks!

I ignored the fact that the dw_apb_timer changes are only in next/drivers,
which comes after next/soc, since those patches are small enough.

	Arnd

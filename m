From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Feb 2018 17:46:05 +0100
Subject: [GIT PULL] omap fixes for v4.16-rc cycle
In-Reply-To: <pull-1518805244-774550@atomide.com>
References: <pull-1518805244-774550@atomide.com>
Message-ID: <CAK8P3a2NnMvm-dNrUJZhqKZBd_U_wga8G_u3=-rebJw9y+ZEqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 7:21 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/fixes-signed
>
> for you to fetch changes up to d39b6ea4f8c90e9e5f03a06b6a4fd4af11e2f617:
>
>   bus: ti-sysc: Fix checking of no-reset-on-init quirk (2018-02-15 09:18:55 -0800)
>
> ----------------------------------------------------------------
> Fixes for omaps for v4.16-rc cycle
>
> This is mostly SoC related fixes for clocks, interconnect, and PM with few
> board specifc dts related fixes:
>
> - Fix quirk handling for ti-sysc to check all quirk flags instead of just
>   the first one
>
> - Fix LogicPD boards for i2c1 muxing to avoid intermittent PMIC errors
>
> - Fix debounce-interval use for omap5-uevm
>
> - Fix debugfs_create_*() usage for omap1
>
> - Fix sar_base initialization for HS omaps
>
> - Fix omap3 prm wake interrupt for resume
>
> - Fix kmemleak for omap_get_timer_dt()
>
> - Enable optional clocks before main clock to prevent interconnect target
>   module from being stuck in transition

Pulled into fixes, thanks!

     Arnd

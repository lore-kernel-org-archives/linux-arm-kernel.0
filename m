From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Sep 2018 13:50:51 -0700
Subject: [GIT PULL] ARM: dts: exynos: DT for v4.20 (or 5.0) (revised)
In-Reply-To: <20180924172133.11786-1-krzk@kernel.org>
References: <20180924172133.11786-1-krzk@kernel.org>
Message-ID: <20180925205051.gdk3jw7mwlom45ox@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 07:21:33PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Pull request without ABI-stability patch.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.20-2
> 
> for you to fetch changes up to ff1e37c6809daab75f7b2dea1efe69330e8eb65b:
> 
>   ARM: dts: exynos: Correct audio subsystem parent clock on Peach Chromebooks (2018-09-24 18:55:16 +0200)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.20
> 
> 1. Bring up DSI and HDMI on Exynos5250 Arndale.
> 2. Use the new way of setting external wakeup interrupts on S5Pv210.
> 3. Use proper cpufreq suspend OPP to fix suspend/wakeup from RAM on Snow
>    Chromebook (Exynos5250).
> 4. Fully describe regualtors on Odroid XU3-family boards.
> 5. Fix sound in Snow-rev5 Chromebook.
> 6. Fix regulators configuration on Peach Pi/Pit Chromebooks (Exynos5420)
>    which should be always on.
> 7. Fix pull control on PMIC interrupt lines on multiple boards which
>    essentially fixes waking up by RTC.
> 8. Add PMIC interrupts on Exynos4210 UniversalC210 board.
> 9. Add external SD card support for Trats board (Exynos4210).
> 10. Correct audio subsystem parent clock on Peach Chromebooks.
> 11. Minor cleanups.

Merged, thanks!


-Olof

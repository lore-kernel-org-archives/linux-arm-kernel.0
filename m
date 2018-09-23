From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 06:20:55 -0700
Subject: [GIT PULL] Rockchip ARM64 devicetree updates for 4.20
In-Reply-To: <2349272.dkc8ODN2Us@phil>
References: <2349272.dkc8ODN2Us@phil>
Message-ID: <20180923132055.5hgyj4qphxxiecaz@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 03:55:15PM +0200, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> please find below the first set of arm64 dt updates for 4.20
> (or however it will be named).
> 
> It's really only 64 bit changes so far [I have one 32bit patch queued up,
> but that isn't really useful on its own, so I'll keep it a bit longer,
> to not send needless 1-patch pull requests ;-) ]

No worries, send it if you want (or just send the patch without a PR, that
works too).

> The tag describes the included changes, so if ok please pull
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts64-1
> 
> for you to fetch changes up to 78f26da3ffbce0ea3692a89fe3f5487cb8dda068:
> 
>   arm64: dts: rockchip: Add type-c port supply on rk3399-sapphire board (2018-09-10 19:16:26 +0200)
> 
> ----------------------------------------------------------------
> New soc support for the px30 quad-core Cortex-A35.
> New boards are the px30 eval board and roc-rk3399-pc.
> The rk3328 got support for the one gpio controlled via the general
> register files and the rk3399 finally got its idle-states defined.
> And finally fixes and improvements for firefly-rk3399 (wifi),
> roc-rk3328-cc (sdmmc-uhs, io-domains), rk3328-rock64 (gpio-regulator
> pin fix) and rk3399-sapphire (gpio-regulator pin fix, pmic pin fix
> and type-c port supply).

Merged, thanks!


-Olof

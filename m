From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jul 2018 19:13:50 -0700
Subject: [GIT PULL 1/2] Rockchip dts64 updates for 4.19 round 2
In-Reply-To: <1809430.FkQi5Ue9ae@phil>
References: <2000491.bLgWuj0xar@phil> <1809430.FkQi5Ue9ae@phil>
Message-ID: <CAOesGMh7hEK_JRk1qKOyLJcr3tB4KVOMMBMUsvXHs0nE1_LGHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 3:35 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Arnd, Kevin, Olof,
>
> please find below some more Rockchip devicetree updates
> targeted at 4.19. With mainly a new board to go on top of the
> first round of patches.
>
> And in a second pull-request just some defconfig64 additions
> enabling yet more stuff for kevin.
>
> If we're not to late for 4.19, please pull!
> Otherwise I'll migrate these over to 4.19+1
>
>
> Thanks
> Heiko
>
> The following changes since commit d0414fdd58eb51ffd6528280fd66705123663964:
>
>   arm64: dts: rockchip: corrected uart1 clock-names for rk3328 (2018-07-07 13:02:27 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.19-rockchip-dts64-2
>
> for you to fetch changes up to 0fbfe10fa96b8df44cfb140a6672f9418e16a2a6:
>
>   arm64: dts: rockchip: add led support for Firefly-RK3399 (2018-07-25 12:19:41 +0200)
>
> ----------------------------------------------------------------
> A new board, the Vamrs Ficus using the rk3399 and followin the 96boards
> standard. LEDs and power button for the rk3399 firefly and removal of
> some deprecated type-c properties from the rk3399 devicetree.

Merged, thanks!


-Olof

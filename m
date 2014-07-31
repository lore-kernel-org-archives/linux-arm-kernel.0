From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jul 2014 22:05:50 -0700
Subject: [GIT PULL] Basic rk3288 usb support
In-Reply-To: <3117047.MiGWvobrqb@diego>
References: <3117047.MiGWvobrqb@diego>
Message-ID: <CAOesGMimqXVPMhM3-GPK4fTUuFfNUP09YHC+ORD98=115uyr3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding LAKML which you seem to have missed in your pull request]

On Wed, Jul 30, 2014 at 9:58 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Arnd, Olof,
>
> thanks to Doug and Kever, the rk3288 devboard can get basic ehci support with
> just some minor dts modifications, so maybe you could pull on top of the
> previous tag:
>
> The following changes since commit b1db66b818a4cb1a654ae51a5ca32a09d1ccd825:
>
>   ARM: dts: Build dtbs for Rockchip boards (2014-07-26 13:07:27 +0200)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.17-rockchip-rk3288-2
>
> for you to fetch changes up to 163cb917b836184c42f185b8fbd9185e20c5f499:
>
>   ARM: dts: Enable USB host0 (EHCI) on rk3288-evb (2014-07-31 05:35:38 +0200)

It's really late in the cycle, but this is a minor increment on top of
an otherwise new platform, so that's OK with me.

Merged. With this I should be able to get my board up and going in the
boot farm sometime next week.


Thanks!

-Olof

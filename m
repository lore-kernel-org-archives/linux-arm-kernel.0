From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 09 May 2017 23:43:05 +0200
Subject: [PATCH 3/4] ARM: dts: rockchip: use pin constants to describe IO
 in pinctrl
In-Reply-To: <1491981044-24635-3-git-send-email-kever.yang@rock-chips.com>
References: <1491981044-24635-1-git-send-email-kever.yang@rock-chips.com>
 <1491981044-24635-3-git-send-email-kever.yang@rock-chips.com>
Message-ID: <3966386.YQGqDXjHSp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 12. April 2017, 15:10:43 CEST schrieb Kever Yang:
> Use command below to replace the IO naming in pinctrl:
> sed -i -e 's/ 31 RK_FUNC_/ RK_PD7 RK_FUNC_/' arch/arm/boot/dts/rk*
> sed -i -e 's/ 0 RK_FUNC_/ RK_PA0 RK_FUNC_/'
> arch/arm64/boot/dts/rockchip/*
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

I'm not sure, if we really want to mass-convert each and every pin.
All pins in use right now seem to be working and it hides other
history/blame for these entries.

In any case though, this needs to be split into separate arm32/arm64
patches.


Heiko

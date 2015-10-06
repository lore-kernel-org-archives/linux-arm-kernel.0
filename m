From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 06 Oct 2015 10:27:56 +0200
Subject: [PATCH 0/5] ARM: dts: rockchip: some regulator updates for
 popmetal and firefly
In-Reply-To: <1443640670-21104-1-git-send-email-heiko@sntech.de>
References: <1443640670-21104-1-git-send-email-heiko@sntech.de>
Message-ID: <2125379.ZDN8aXPFAA@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 30. September 2015, 21:17:45 schrieb Heiko Stuebner:
> The upcoming mmc tuning definitly needs correct handling of the iodomains,
> which is also good to have in general. So this fixes some small regulator
> issues and then adds the io-domains for the rk3288 popmetal and firefly
> boards.
> 
> Heiko Stuebner (5):
>   ARM: dts: rockchip: add rk3288-popmetal board to dtb list
>   ARM: dts: rockchip: add rk3288-popmemtal mmc supplies
>   ARM: dts: rockchip: add rk3288-popmetal iodomains
>   ARM: dts: rockchip: fixup firefly mmc supplies
>   ARM: dts: rockchip: add rk3288-firefly iodomains

applied these to my dts branch for 4.4

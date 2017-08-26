From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 26 Aug 2017 11:52:21 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add rk3288 vyasa board
In-Reply-To: <1503730303-11422-2-git-send-email-jteki@openedev.com>
References: <1503730303-11422-1-git-send-email-jteki@openedev.com>
 <1503730303-11422-2-git-send-email-jteki@openedev.com>
Message-ID: <71627494.SRV9zSqJ5i@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

Am Samstag, 26. August 2017, 12:21:43 CEST schrieb Jagan Teki:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> This patch adds initial support for rk3288 based
> Vyasa board, which is made by Amarula Solutions.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/Makefile         |   3 +-
>  arch/arm/boot/dts/rk3288-vyasa.dts | 312 +++++++++++++++++++++++++++++++++++++

please also add an entry for the board to
	Documentation/devicetree/bindings/arm/rockchip.txt

Otherwise looks good on first glance. I'll probably move some properties
myself to their alphabetical position when applying.


Heiko

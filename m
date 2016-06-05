From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jun 2016 00:14:01 +0200
Subject: [PATCH 0/3] arm64: dts: rockchip: add io-domain support for
 rk3368 and rk3399
In-Reply-To: <1463865828-14583-1-git-send-email-heiko@sntech.de>
References: <1463865828-14583-1-git-send-email-heiko@sntech.de>
Message-ID: <488393040.q3pmEmijvh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 21. Mai 2016, 23:23:45 schrieb Heiko Stuebner:
> This adds the core io-domain nodes for both the rk3368 and rk3399
> as well as the actual supplies on the rk3368-r88 board.
> 
> This of course needs
>     PM / AVS: rockchip-io: make io-domains a child of the GRF
> that went into mainline during the 4.7 merge window.
> 
> Heiko Stuebner (3):
>   arm64: dts: rockchip: add rk3368 io-domain core nodes
>   arm64: dts: rockchip: add rk3368-r88 iodomains
>   arm64: dts: rockchip: add rk3399 io-domain core nodes

I have all 3 in my dts64 branch now.

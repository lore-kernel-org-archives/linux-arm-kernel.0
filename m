From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Mar 2015 15:23:13 +0100
Subject: [GIT PULL] ARM: rockchip: small fixes for 4.0-rc
In-Reply-To: <3637038.xZyfPJIQzf@phil>
References: <3637038.xZyfPJIQzf@phil>
Message-ID: <4556908.EaV8ua9jfr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 March 2015 00:57:29 Heiko Stuebner wrote:
> Hi Arnd, Olof,
> 
> a small issue surfaced with the new gmac node on rk3288 which is missing a
>         status = "disabled";
> in the rk3288.dtsi and thus enabling the mac unconditionally.
> The second patch in that branch simply adds a rockchip regexp to MAINTAINERS, so
> that it also matches stuff like the (slightly) new rockchip drm stuff.
> 
> So if acceptable, please pull
> 
> 

Pulled into fixes, thanks!

	Arnd

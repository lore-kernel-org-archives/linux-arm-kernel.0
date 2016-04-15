From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 15 Apr 2016 23:21:53 +0200
Subject: [PATCH v2 2/5] ARM: dts: rockchip: make rk3288-grf a simple-mfd
In-Reply-To: <1459432126-6395-3-git-send-email-heiko@sntech.de>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
 <1459432126-6395-3-git-send-email-heiko@sntech.de>
Message-ID: <2780445.ZUVl1WxXtY@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 31. M?rz 2016, 15:48:43 schrieb Heiko Stuebner:
> Similar to the pmu, the general register files contain a lot of different
> setting bits grouped into general registers, but also some somewhat special
> entities like the controls for some phy-blocks or the io-voltage control.
> To be able to move these blocks under the grf node where they actually
> belong, make it a simple-mfd.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I've picked this patch into my dts32 branch for v4.7, as I need it as base for 
some other change as well.

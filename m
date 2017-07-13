From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Jul 2017 19:13:20 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: remove arm,
 mali-midgard compatible from rk3288
In-Reply-To: <20170710121227.14264-2-heiko@sntech.de>
References: <20170710121227.14264-1-heiko@sntech.de>
 <20170710121227.14264-2-heiko@sntech.de>
Message-ID: <2174958.YDB435SJ6H@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 10. Juli 2017, 14:12:27 CEST schrieb Heiko Stuebner:
> The binding specifies the actual implementations only (mali-t760
> for example) but not the arm,mali-midgard used in some vendor kernels.
> So drop that compatible property from the rk3288 where it had slipped in.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied as fix for 4.13 after also fixing the node name to gpu at ...
as spotted by Rob.

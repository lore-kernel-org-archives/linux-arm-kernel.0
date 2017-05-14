From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 14 May 2017 14:54:53 +0200
Subject: [PATCH v2 6/6] ARM: dts: rockchip: rename RK1108-evb to RV1108-evb
In-Reply-To: <20170317171840.4683-7-heiko@sntech.de>
References: <20170317171840.4683-1-heiko@sntech.de>
 <20170317171840.4683-7-heiko@sntech.de>
Message-ID: <17588038.0Ltp2v6IRL@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 17. M?rz 2017, 18:18:40 CEST schrieb Heiko Stuebner:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Rockchip finally named the SOC as RV1108, so change it
> for compatible.
> 
> The rk1108/rv1108 is completely new to the market, so there no real
> devices exist in the wild, only the Rockchip internal evaluation
> board. Therefore we're not breaking any existing devices when
> changing compatible values.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> [added paragraph about no real devices existing]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

adapted for Makefile changes in 4.12-rc1 and applied for 4.13

From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 14 Sep 2017 23:46:17 +0200
Subject: [PATCH] arm64: dts: rockchip: enable display subsystem on
 rk3399-firefly
In-Reply-To: <20170824154919.12324-1-heiko@sntech.de>
References: <20170824154919.12324-1-heiko@sntech.de>
Message-ID: <3392920.sc8iAoP2eY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 24. August 2017, 17:49:19 CEST schrieb Heiko Stuebner:
> Enable the graphics-related nodes on the rk3399-firefly which makes
> it possible to see output on the on-board hdmi output.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 4.15 after dropping the assigned-clock properties.
We have clock defaults for the vops in rk3399.dtsi now and
the firefly works nicely without them here.

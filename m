From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Nov 2012 15:52:51 +0000
Subject: [PATCH 1/4] ARM: sunxi: Restructure sunxi dts/dtsi files
In-Reply-To: <1353323383-11827-1-git-send-email-sr@denx.de>
References: <1353323383-11827-1-git-send-email-sr@denx.de>
Message-ID: <201211191552.52053.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 November 2012, Stefan Roese wrote:
> For the new sun4i/Cubieboard (A10) support, lets re-strucure the
> sun5i dts files to make it more generic. Those are the new
> dts/dtsi files:
> 
> sunxi.dtsi - Devices common to all Allwinner sunXi SoC's
> sun4i.dtsi - sun4i Devices, will include sunxi.dtsi
> sun5i.dtsi - sun5i Devices, will include sunxi.dtsi
> board.dts - will include either sun4i.dtsi or sun5i.dtsi
> 
> Additionally the "duart" label in the olinuxino.dts is changed to
> "uart1".
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

The patch looks good, but I think you didn't pass the '-M' argument
to git-format-patch, which would have made it more readable.

	Arnd

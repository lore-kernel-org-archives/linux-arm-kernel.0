From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Mar 2017 12:49:26 +0100
Subject: [PATCH v2] ARM: dts: imx6q-cm-fx6: add analog audio support
In-Reply-To: <c53afd927fae4a1dbd84ab8122e6c794@rwthex-s1-b.rwth-ad.de>
References: <c53afd927fae4a1dbd84ab8122e6c794@rwthex-s1-b.rwth-ad.de>
Message-ID: <20170308114925.GE12997@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 09:44:04PM +0100, christopher.spinrath at rwth-aachen.de wrote:
> From: Valentin Raevsky <valentin@compulab.co.il>
> 
> The cm-fx6 module has an onboard Wolfson wm8731 codec which is muxed
> to the ssi2 controller. Unlike most (all?) supported i.MX6 board/codec
> combinations the wm8731 is operated in slave mode and the clock setup
> is static.
> 
> Add support for it.
> 
> Signed-off-by: Valentin Raevsky <valentin@compulab.co.il>
> [christopher.spinrath at rwth-aachen.de: enhanced commit message, ported
>   to upstream and some cleanup]
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.

From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 14 Dec 2017 17:47:31 +0100
Subject: [PATCH v7 6/6] arm64: dts: meson-axg: switch uart_ao clock to
 CLK81
In-Reply-To: <20171211141348.22048-7-yixun.lan@amlogic.com>
References: <20171211141348.22048-1-yixun.lan@amlogic.com>
 <20171211141348.22048-7-yixun.lan@amlogic.com>
Message-ID: <1513270051.2261.11.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 22:13 +0800, Yixun Lan wrote:
> Switch the uart_ao pclk to CLK81 since the clock driver is ready.
> Also move the clock info to the board.dts instead in the soc.dtsi.

Same comment as for ethmac, is it really wise ?
Isn't the clock setup the same for the axg family ?

> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

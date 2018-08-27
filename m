From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 27 Aug 2018 15:21:40 +0200
Subject: [PATCH] clk: meson-axg: pcie: drop the mpll3 clock parent
In-Reply-To: <20180801121625.9488-1-yixun.lan@amlogic.com>
References: <20180801121625.9488-1-yixun.lan@amlogic.com>
Message-ID: <9dd477896f4dc3b354d5875f8c4ecce1807c375c.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-08-01 at 12:16 +0000, Yixun Lan wrote:
> We found the PCIe driver doesn't really work with
> the mpll3 clock which is actually reserved for debug,
> So drop it from the mux list.
> 
> Fixes: 33b89db68236 ("clk: meson-axg: add clocks required by pcie driver")
> Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> 
> ---

Applied, Thx

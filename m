From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 28 Nov 2016 09:21:57 +0000
Subject: [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <20161128091456.GR14217@n2100.armlinux.org.uk>
References: <8737icayac.wl%kuninori.morimoto.gx@renesas.com>
 <20161128091456.GR14217@n2100.armlinux.org.uk>
Message-ID: <87wpfo9d0b.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell

> > Current Linux has of_clk_get(), but doesn't have devm_of_clk_get().
> > This patch adds it. This is based on devm_clk_get()
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Please put this in drivers/clk/clk-devres.c, where you'll find that
> we have devm_clk_release() which is identical to your
> devm_of_clk_release().  It'll also not need the dummy definition of
> devm_of_clk_get().

OK, will do

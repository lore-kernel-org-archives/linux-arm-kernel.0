From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 9 Dec 2016 00:25:48 +0000
Subject: [PATCH 0/3] clkdev: add devm_get_clk_from_child()
In-Reply-To: <20161208220824.GM5423@codeaurora.org>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
 <20161208220824.GM5423@codeaurora.org>
Message-ID: <8737hyymo9.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen, Mark

> > This is v5 of "clkdev: add devm_of_clk_get()", but new series.
> > I hope my understanding was correct with your idea.
> 
> Yes this looks good. Given that we're so close to the merge
> window, perhaps I should just merge the first patch into clk-next
> and then it will be ready for anyone who wants to use it? The
> sound patches can be left up to others to handle.

OK thanks.
Mark, I think I should re-post 2nd patch (3rd will be dropped) after
merge window ? There will be no branch dependency

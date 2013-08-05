From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 05 Aug 2013 12:07:03 -0700
Subject: [PATCH] clk: sunxi: Fix checking return value of
 clk_register_[composite|factors]
In-Reply-To: <20130715134235.GF2962@lukather>
References: <1373616915.24328.1.camel@phoenix> <20130715134235.GF2962@lukather>
Message-ID: <20130805190703.5348.66176@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2013-07-15 06:42:35)
> Hi Axel,
> 
> 
> On Fri, Jul 12, 2013 at 04:15:15PM +0800, Axel Lin wrote:
> > clk_register_composite() and clk_register_factors() return ERR_PTR on error.
> > 
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Taken into clk-next.

Thanks!
Mike

> 
> Thanks for this patch!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

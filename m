From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 6 Feb 2016 10:37:51 +0100
Subject: [PATCH v4 1/2] clk: sunxi: Add sun6i/8i video support
In-Reply-To: <20160205093915.GF1139@lukather>
References: <cover.1454435944.git.moinejf@free.fr>
 <3c0e2cdea659e9e682f80ecf42b252c740095f15.1454435944.git.moinejf@free.fr>
 <20160205093915.GF1139@lukather>
Message-ID: <20160206103751.eb21edf56ddc6ef7c27907f0@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Feb 2016 10:39:15 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > +CLK_OF_DECLARE(sun6i_display, "allwinner,sun6i-display-clk", sun6i_display_setup);
> 
> Please use the display driver from my DRM serie, it covers everything
> you need here.

If you give me a pointer, I will have a look.

> > +CLK_OF_DECLARE(sun6i_pll3, "allwinner,sun6i-pll3-clk", sun6i_pll3_setup);
> 
> And please use the clk-factors code here.

I don't see how I can get direct 297MHz and 270MHz in fractional mode
with that code.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

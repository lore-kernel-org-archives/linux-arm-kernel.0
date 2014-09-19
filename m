From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 19 Sep 2014 16:33:12 +0000 (UTC)
Subject: [PATCH] clk: ti: change clock init to use generic of_clk_init
In-Reply-To: <20140918171725.GL14505@atomide.com>
References: <1408628959-32442-1-git-send-email-t-kristo@ti.com>
 <20140918171725.GL14505@atomide.com>
Message-ID: <alpine.DEB.2.02.1409191632170.22526@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Sep 2014, Tony Lindgren wrote:

> * Tero Kristo <t-kristo@ti.com> [140821 06:52]:
> > Previously, the TI clock driver initialized all the clocks hierarchically
> > under each separate clock provider node. Now, each clock that requires
> > IO access will instead check their parent node to find out which IO range
> > to use.
> > 
> > This patch allows the TI clock driver to use a few new features provided
> > by the generic of_clk_init, and also allows registration of clock nodes
> > outside the clock hierarchy (for example, any external clocks.)
> 
> Paul, any comments on this one?

Not at this point.


- Paul

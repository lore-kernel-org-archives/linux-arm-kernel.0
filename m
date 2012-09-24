From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 24 Sep 2012 20:57:40 +0000 (UTC)
Subject: [PATCH] ARM: am33xx: clk: Update clkdev table to add mcasp alias
In-Reply-To: <20120924184924.GI28835@atomide.com>
References: <1348509399-3391-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1209241832430.24053@utopia.booyaka.com>
 <20120924184924.GI28835@atomide.com>
Message-ID: <alpine.DEB.2.00.1209242057210.25811@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Sep 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120924 11:34]:
> > On Mon, 24 Sep 2012, Vaibhav Hiremath wrote:
> > 
> > > After Rajendra's common-clock preparation series,
> > > commit (a1978ef4da1 - ARM: omap: hwmod: get rid of
> > > all omap_clk_get_by_name usage) the clkdev table need to
> > > update with an entry for clocks used by hwmod to have
> > > clock name same as the alias.
> > > 
> > > Without this, the clk_get() in omap_hwmod would fail.
> > > 
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > 
> > Tony, if you want to take this, it's
> > 
> > Acked-by: Paul Walmsley <paul@pwsan.com>
> > 
> > otherwise we'll wait for -rc1.
> 
> Please just go ahead and queue it as a fix.
> 
> We should get a fixes branch in before -rc1 is tagged
> so -rc1 works for us.

OK, will send a pull request once devel-late goes upstream.


- Paul

From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 8 Jan 2010 12:38:31 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <1262913477.2173.696.camel@pasglop>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<1262913477.2173.696.camel@pasglop>
Message-ID: <201001081238.31842.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

> > +int clk_enable(struct clk *clk)
> > +{
> > +	if (clk->enable)
> > +		return clk->enable(clk);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(clk_enable);
> 
>  .../...
> 
> All those guys look like good candidates to be inlined :-)

Good point, will inline these.

Cheers,


Jeremy

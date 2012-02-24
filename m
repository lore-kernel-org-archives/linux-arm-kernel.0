From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 24 Feb 2012 16:42:12 +0200
Subject: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
In-Reply-To: <20120224143415.GL5450@opensource.wolfsonmicro.com>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
 <20120224114940.GB5450@opensource.wolfsonmicro.com>
 <1330089398.4102.539.camel@sokoban>
 <20120224132408.GF5450@opensource.wolfsonmicro.com>
 <1330091765.4102.547.camel@sokoban>
 <20120224140109.GG5450@opensource.wolfsonmicro.com>
 <1330093512.4102.552.camel@sokoban>
 <20120224143415.GL5450@opensource.wolfsonmicro.com>
Message-ID: <1330094532.4102.555.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-02-24 at 14:34 +0000, Mark Brown wrote:
> On Fri, Feb 24, 2012 at 04:25:12PM +0200, Tero Kristo wrote:
> 
> > Still, setting selector in this case does nothing, as it is immediately
> > overwritten by the regulator core by -1. This looks like a perfectly
> > acceptable way to implement a regulator, as everything checks for the
> > presence of list_voltage anyway.
> 
> Ah, so it is - we're fixing things up in the core.  I'd forgotten we did
> that.

So, no need to add list_voltage to this, I just fix the return values
for the get / set and send the new version, am I right?

-Tero

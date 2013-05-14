From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 May 2013 15:52:21 -0700
Subject: OMAP baseline test results for v3.9
In-Reply-To: <alpine.DEB.2.00.1305142116001.4368@utopia.booyaka.com>
References: <alpine.DEB.2.00.1305081933270.19747@utopia.booyaka.com>
 <20130514211328.GC5600@atomide.com>
 <alpine.DEB.2.00.1305142116001.4368@utopia.booyaka.com>
Message-ID: <20130514225221.GD5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130514 14:24]:
> On Tue, 14 May 2013, Tony Lindgren wrote:
> 
> > Hi,
> > 
> > * Paul Walmsley <paul@pwsan.com> [130508 12:45]:
> > > 
> > > PM off, dynamic idle:
> > >     FAIL ( 2/ 5): 4430es2panda, 4460pandaes
> > >     Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm
> > 
> > Looking at your pm logs, 3730beaglexm won't hit off-idle.
> > I've pasted the relevant lines from your logs below.
> > 
> > Is this a known issue?
> 
> Yes, the Beagle XM in my testbed is a 3630ES1.0.  From the PM logs:
> 
> [   63.154418] omap3_pm_off_mode_enable: Core OFF disabled due to errata 
> i583
> 
> I should probably clarify how this is reported in the test results.

Thanks that explains. BTW, the "PM off" naming might make some
people think that CONFIG_PM is not set :)

Regards,

Tony

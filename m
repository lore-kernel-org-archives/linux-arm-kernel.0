From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Jun 2013 07:57:24 -0700
Subject: N900 device tree conversion: how to do first step
In-Reply-To: <20130613142809.GA3775@amd.pavel.ucw.cz>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
 <20130609201119.GA3190@blackmetal.musicnaut.iki.fi>
 <20130613132624.GA3464@amd.pavel.ucw.cz>
 <20130613141001.GF8164@atomide.com>
 <20130613142809.GA3775@amd.pavel.ucw.cz>
Message-ID: <20130613145724.GH8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [130613 07:34]:
> On Thu 2013-06-13 07:10:01, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [130613 06:32]:
> >  
> > > If I init spi manually (and some more hacks), it works in the
> > > qemu. But I have not tested on real hw for a while.
> > 
> > You should be able to initialize spi by adding the .dts entry,
> > or is there something missing in drivers/spi/spi-omap2-mcspi.c?
> 
> Not sure, I guess I'll find out soon. Do you have example dts that
> uses drivers/spi/spi-omap2-mcspi.c? Grepping spi in dts/ was not too
> successful.

Hmm I think all we have is what's written in
Documentation/devicetree/bindings/spi/omap-spi.txt and
omap4-sdp.dts.

Regards,

Tony

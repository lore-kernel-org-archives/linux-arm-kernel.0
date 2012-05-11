From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 May 2012 17:31:45 +0200
Subject: [GIT PULL] i.MX common clock support
In-Reply-To: <201205111527.15765.arnd@arndb.de>
References: <20120509071500.GC16535@pengutronix.de>
 <201205111514.37138.arnd@arndb.de>
 <20120511151904.GH27341@pengutronix.de>
 <201205111527.15765.arnd@arndb.de>
Message-ID: <20120511153145.GI27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 03:27:15PM +0000, Arnd Bergmann wrote:
> On Friday 11 May 2012, Sascha Hauer wrote:
> > On Fri, May 11, 2012 at 03:14:36PM +0000, Arnd Bergmann wrote:
> > > On Wednesday 09 May 2012, Sascha Hauer wrote:
> > > > Hi Arnd, Olof,
> > > > 
> > > > Please pull the following i.MX common clock support branch for next.
> > > > 
> > > > Same as with Shawns series this one depends on:
> > > > 
> > > > git://git.linaro.org/people/mturquette/linux.git clk-next
> > > > http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git clkdev
> > > > 
> > > 
> > > I've put all of those on the next/clock branch now.
> > 
> > So do you want me to rebase my stuff on arm-soc/next/clock then?
> > 
> 
> I'm not sure if we're talking about the same things. I mean I've put
> pulledthe clk-next branch from Mike and the clkdev branch from Russell
> into the next/clock branch and pulled both your imx series and Shawn's
> mxs series on top into the same branch.

Yes, we are talking about the same thing. I immediately pulled arm-soc
and have found the dependencies but not the imx clock patches. Now they
are there \o/

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

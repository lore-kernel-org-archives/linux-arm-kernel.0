From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 May 2012 15:27:15 +0000
Subject: [GIT PULL] i.MX common clock support
In-Reply-To: <20120511151904.GH27341@pengutronix.de>
References: <20120509071500.GC16535@pengutronix.de>
 <201205111514.37138.arnd@arndb.de> <20120511151904.GH27341@pengutronix.de>
Message-ID: <201205111527.15765.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 May 2012, Sascha Hauer wrote:
> On Fri, May 11, 2012 at 03:14:36PM +0000, Arnd Bergmann wrote:
> > On Wednesday 09 May 2012, Sascha Hauer wrote:
> > > Hi Arnd, Olof,
> > > 
> > > Please pull the following i.MX common clock support branch for next.
> > > 
> > > Same as with Shawns series this one depends on:
> > > 
> > > git://git.linaro.org/people/mturquette/linux.git clk-next
> > > http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git clkdev
> > > 
> > 
> > I've put all of those on the next/clock branch now.
> 
> So do you want me to rebase my stuff on arm-soc/next/clock then?
> 

I'm not sure if we're talking about the same things. I mean I've put
pulledthe clk-next branch from Mike and the clkdev branch from Russell
into the next/clock branch and pulled both your imx series and Shawn's
mxs series on top into the same branch.

If you're talking about those patches, then there is no need to rebase
them AFAICT. If you have other patches building on your clock series,
you should rebase them to whatever is the minimum set of dependencies,
which may or may not be this branch.

	Arnd

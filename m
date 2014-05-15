From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 May 2014 17:11:00 -0700
Subject: [PATCH] bus/omap_l3: avoid sync initcall for modules
In-Reply-To: <5640589.bzCk17dFyc@wuerfel>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <20140513162731.GD16837@atomide.com>
 <20140514173931.GA14003@kroah.com> <5640589.bzCk17dFyc@wuerfel>
Message-ID: <20140515001100.GB31594@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [140514 11:16]:
> On Wednesday 14 May 2014 10:39:31 Greg KH wrote:
> > On Tue, May 13, 2014 at 09:27:33AM -0700, Tony Lindgren wrote:
> > > * Arnd Bergmann <arnd@arndb.de> [140513 08:13]:
> > > 
> > > I did not look what percentage has tristate in the Kconfig,
> > > but that might keep some people from making loadable drivers.
> > > 
> > > Greg, is the following patch something you may want to
> > > consider picking up?
> > 
> > Sure, is this needed to fix issues in 3.15-final, or is 3.16-rc1 ok?
> 
> I don't think anyone cares about it outside of randconfig builds,
> so 3.16-rc1 is ok.

Yeah thanks.

Tony

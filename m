From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 14 Feb 2013 12:28:45 +0200
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <20130213165439.GH7144@atomide.com>
References: <511A0F11.1050608@stericsson.com>
 <201302121741.31494.arnd@arndb.de>
 <511B59E2.5060402@stericsson.com>
 <201302131104.01793.arnd@arndb.de>
 <20130213165439.GH7144@atomide.com>
Message-ID: <20130214102845.GJ3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 05:54:39PM +0100, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [130213 03:07]:
> > On Wednesday 13 February 2013, Jean-Nicolas GRAUX wrote:
> > > Le 02/12/2013 06:41 PM, Arnd Bergmann a ?crit :
> > > > On Tuesday 12 February 2013, Jean-Nicolas GRAUX wrote:
> > > > If a more dynamic user interface is needed, I think it would be good
> > > > to have a generic mechanism in the pinctrl subsystem to reroute pins
> > > > like these, which can work for all pins in the system (or at least
> > > > those that have not been claimed by another device). I don't know if
> > > > that interface already exists, but Linus would be the right person
> > > > to answer that.
> > >
> > > I think i have one colleague that recently made a patch for that purpose.
> > > But i believe this is still in progress. It consists in improving the 
> > > pinctrl
> > > debugfs interface to be able to manually change the pin muxing and
> > > the gpio configuration for debug/testing purpose.
> > 
> > Sounds good to me. Peter, Tony, do you think that would be a good enough
> > interface for other platforms as well?
> 
> Yes debugfs is the way to go for modifying the hwobs settings.

Agreed. debugfs would be fine.

Cheers,

Peter.

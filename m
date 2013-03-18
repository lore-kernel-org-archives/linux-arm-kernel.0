From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 18 Mar 2013 12:26:16 -0400
Subject: [PATCH v2 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <201303181558.59608.arnd@arndb.de>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303181459.10954.arnd@arndb.de> <20130318162411.11c9e3ab@skate>
 <201303181558.59608.arnd@arndb.de>
Message-ID: <20130318162616.GJ13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Mon, Mar 18, 2013 at 03:58:59PM +0000, Arnd Bergmann wrote:
> On Monday 18 March 2013, Thomas Petazzoni wrote:
> > So even the DT-only sub-architecture (such as mvebu) should hard-code
> > the register base addresses?
> > 
> > The proposed DT binding in the current patch is very minimal, and I
> > don't see why the more elaborate DT binding that you proposed could not
> > be implemented as an improvement of it: the DT binding you proposed
> > seems backward compatible with the one currently implemented, no?
> 
> It's quite possible that it could be done in a backward compatible
> way, I just like to be on the safe side in case it's not.

We do have a bit more latitude here.  There isn't a single shipping
mvebu device with a fdt enabled bootloader.  So, as long as we aren't
impacting other SoCs/drivers, I'm comfortable with taking a release or
two to shake it out.  I understand we prefer not to do that, but in this
case, I don't want to hold up everything else in the pipeline.

thx,

Jason.

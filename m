From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 12 Sep 2013 13:04:55 +0200
Subject: [PATCH v2 8/9] spi: prepare runtime PM support for SPI devices
In-Reply-To: <20130912094302.GM7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130912093145.GA29403@sirena.org.uk> <20130912094302.GM7393@intel.com>
Message-ID: <14222641.vVF4lKBqCB@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 12, 2013 12:43:02 PM Mika Westerberg wrote:
> On Thu, Sep 12, 2013 at 10:31:45AM +0100, Mark Brown wrote:
> > On Thu, Sep 12, 2013 at 12:27:43PM +0300, Mika Westerberg wrote:
> > > On Wed, Sep 11, 2013 at 04:51:20PM +0100, Mark Brown wrote:
> > 
> > > > I would be able to have this and the other patch in the SPI tree in case
> > > > it overlaps with other work - I'm not sure what the plan will be for
> > > > merging this stuff but if there were a branch which I could merge into
> > > > the SPI tree that'd be good.
> > 
> > > I think these two can go via your SPI tree as they shouldn't have
> > > dependencies to the I2C tree.
> > 
> > There's all the driver changes though - it seems best to push the whole
> > series through one branch so there's fewer bisection problems.
> 
> Ah, right. Then I suppose the right tree would be the I2C tree (as majority
> of the patches are I2C related)?
> 
> Wolfram, are you OK with this?

Alternatively, I can apply them too if everyone is OK with that.

They are PM+ACPI changes after all ...

Thanks,
Rafael

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 May 2014 16:17:39 +0100
Subject: [PATCH] acornscsi: remove linked command support
In-Reply-To: <1401287204.2288.28.camel@dabdike>
References: <1400926433.31526.89.camel@x220>
 <20140528104114.GE13542@infradead.org> <1401287204.2288.28.camel@dabdike>
Message-ID: <20140528151739.GJ3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 06:26:44PM +0400, James Bottomley wrote:
> On Wed, 2014-05-28 at 03:41 -0700, Christoph Hellwig wrote:
> > Looks good,
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > And I have to disagree with James here, removing code that isn't even
> > compiled always is an improvement, especially for an unmaintained
> > driver.
> 
> Well, as I said, this is in theory a maintained driver, so just get an
> ack from Russell and this debate is moot.

I don't see any harm in removing this - I don't think I've owned any
SCSI devices which supported linked commands, which is why I never
put much effort into it.  As no one else seems to care about it (given
the number of years it's been left alone), removing the linked command
stuff is fine.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

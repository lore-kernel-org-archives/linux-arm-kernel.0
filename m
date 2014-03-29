From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Mar 2014 18:13:06 +0000
Subject: [PATCH 00/26] OMAP dma engine rework
In-Reply-To: <20140318154845.GE1976@intel.com>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
 <20140318154845.GE1976@intel.com>
Message-ID: <20140329181306.GE27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 09:18:45PM +0530, Vinod Koul wrote:
> On Mon, Feb 10, 2014 at 09:25:31PM +0530, Russell King - ARM Linux wrote:
> > This is the current set of patches for the OMAP DMA engine rework,
> > which should now work correctly on OMAP1 platforms thanks to Tony's
> > testing.
> > 
> > It would be good to get this validated by others across a range of
> > OMAP platforms, and queued up for the next merge window, so it can
> > be built upon.
> > 
> > Acks appreciated, and once sufficient have been added, I'll send a
> > pull request for this to Vinod.
> So is this series finalized. I havent seen the pull request for this or did i
> miss it!

Gah, missed this.

As nothing has changed with it since 18th February, which was to add
Tony's ack to the set.  I think it's as good as it's going to get for
the time being.  It's also been in linux-next all this time, and no
one has reported any problems.  I'll need to sort out a proper pull
request for it ASAP... or something.  An alternate solution would be
your blessing for this set.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

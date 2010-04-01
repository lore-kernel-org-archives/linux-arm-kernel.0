From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 1 Apr 2010 19:00:04 +0200
Subject: Memory corruption with 2.6.32.10, but not with 2.6.34-rc3
In-Reply-To: <20100401165056.GA1138@suse.de>
References: <20100401132156.GJ30807@buzzloop.caiaq.de>
	<20100401165056.GA1138@suse.de>
Message-ID: <20100401170004.GO30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 01, 2010 at 09:50:56AM -0700, Greg KH wrote:
> On Thu, Apr 01, 2010 at 03:21:56PM +0200, Daniel Mack wrote:
> > So my current summary is that this is related to WiFi, but OTOH it still
> > only happens when file system traffic is issued.
> > 
> > We would like to have a fix for this annoying bug in the stable series
> > (especially 2.6.32.x) as well, but I don't have much ideas about where
> > to search for it. Hence, I would appreciate if maintainers could think
> > about any possible commits in the described time window which haven't
> > reached stable. Does the description ring anyone's bell?
> 
> I can't think of any USB specific patches that would be related to this,
> sorry.

Yes, I'd rule out USB anyway. It crashes without any USB function as
well. I just copied you as the maintainer of the stable tree :)

Daniel

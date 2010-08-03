From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Aug 2010 12:40:40 +0300
Subject: [GIT PULL] debug macro changes for 2.6.36
In-Reply-To: <20100731092838.GE23886@n2100.arm.linux.org.uk>
References: <1280465905.11181.41.camel@pororo.lan>
	<20100730071805.GB29746@n2100.arm.linux.org.uk>
	<1280474636.27902.1.camel@pororo.lan>
	<20100730081419.GA3208@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1007302138380.30558@xanadu.home>
	<20100731092838.GE23886@n2100.arm.linux.org.uk>
Message-ID: <20100803094040.GX12293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100731 12:27]:
> On Fri, Jul 30, 2010 at 09:46:16PM -0400, Nicolas Pitre wrote:
> > On Fri, 30 Jul 2010, Russell King - ARM Linux wrote:
> > > My intention was to have your patch merged - as patches - into an
> > > appropriate place in my tree, and then just before the merge window
> > > run that script to remove all the references to phys_io/io_pg_offst,
> > > and finally, some time later, the members from the structure.
> > 
> > Just to be clear, would you prefer for Jeremy to send you those initial 
> > patches through your patch system or via a Git pull request?
> 
> I think patches would be better, so there's no dependencies on stuff I
> have in my tree already - and I'll be free to add them at the most
> appropriate point.
> 
> However, it seems one of the patches still contains questions over OMAP
> which haven't been addressed (or maybe they have and the commit comment
> hasn't been updated.)  That needs resolving before they can be merged.
> I've forwarded the email to linux-omap and Tony, but I'm not expecting
> a reply before Monday or so as OMAP folk seem to keep to sane working
> hours.

Sorry for being a bottleneck here, just got back from a vacation
yesterday. Looking at these patches today.

Regards,

Tony

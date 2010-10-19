From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Oct 2010 18:34:09 -0700
Subject: [PATCH 0/3] Allow late mdesc detection, v4
In-Reply-To: <alpine.LFD.2.00.1010181030500.2764@xanadu.home>
References: <1282553423.737985.983362819420.0.gpush@pororo>
	<20100901073913.GF8142@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010142331220.2764@xanadu.home>
	<20101018141956.GF12449@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010181030500.2764@xanadu.home>
Message-ID: <20101019013409.GN13341@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [101018 07:23]:
> On Mon, 18 Oct 2010, Russell King - ARM Linux wrote:
> 
> > On Thu, Oct 14, 2010 at 11:42:04PM -0400, Nicolas Pitre wrote:
> > > I think that time has come, or is very close.  And since Jeremy is away 
> > > on vacation he asked me to handle the submission for those patches on 
> > > his behalf.
> > > 
> > > So... could you pull the following:
> > > 
> > > 	git://git.linaro.org/people/nico/linux debug_cleanup
> > > 
> > > It is currently based on your devel branch at commit f7de6b55ea4. If 
> > > you'd prefer another base just tell me.
> > 
> > I'm going to drop this - there's still a few trees which are outstanding
> > and this is causing problems... I think we have a few days left.
> > 
> > With Eric's changes merged, there's another io_pg_offst which has popped
> > up in mach-mmp, and there's a few new OMAP boards external to my tree
> > which are broken by this.
> 
> No problem.  Just tell me when you're done merging those other trees and 
> I'll rebase/adjust this series on top for you to pull again.

Hmm, these patches are not a problem at least from omap tree point
of view.

We already tested an earlier version of these patches a while back,
and I just applied them to our temporary omap-testing branch, and
things work as expected.

The only fixup that we need to fix up few omap specific board files.
I've added the fixups to the omap for-next, and I can merge with mainline
tree to fix these before sending the pull request.

Regards,

Tony

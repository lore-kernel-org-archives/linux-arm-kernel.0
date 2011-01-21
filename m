From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 21 Jan 2011 12:23:30 +0000
Subject: [PATCH] ARM: aaec2000: remove support for mach-aaec2000
In-Reply-To: <20110121120218.GP13235@n2100.arm.linux.org.uk>
References: <1294430422-939-1-git-send-email-jamie@jamieiles.com>
	<20110121111355.GN13235@n2100.arm.linux.org.uk>
	<20110121120006.GE6768@pulham.picochip.com>
	<20110121120218.GP13235@n2100.arm.linux.org.uk>
Message-ID: <20110121122330.GG6768@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 12:02:18PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 21, 2011 at 12:00:06PM +0000, Jamie Iles wrote:
> > On Fri, Jan 21, 2011 at 11:13:55AM +0000, Russell King - ARM Linux wrote:
> > > On Fri, Jan 07, 2011 at 08:00:22PM +0000, Jamie Iles wrote:
> > > > mach-aaec2000 is no longer actively maintained and is only receiving
> > > > fixups to remain building with other kernel updates.
> > > > 
> > > > Cc: Bellido Nicolas <ml@acolin.be>
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > > 
> > > Okay, could you send the two patches to the patch system and I'll add it
> > > to a 'remove' branch (which now has lh7a40x in as well) for 2.6.39.
> > 
> > Dmitry has taken the keyboard driver into his tree so I've just 
> > submitted the mach removal one to the patch system.
> 
> I suggest basing it against mainline rather than my devel branch,
> otherwise it'll have to sit on top of the p2v code (and I'd rather
> not have it depend on other stuff.)  I'll modify the p2v stuff to
> avoid the conflicts.

Ok, no problem.  Resubmitted based of 2.6.38-rc1.

Jamie

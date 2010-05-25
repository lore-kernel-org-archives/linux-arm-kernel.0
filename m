From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 May 2010 08:31:24 +0100
Subject: samsung merge window over
In-Reply-To: <004b01cafbce$7b249430$716dbc90$%kim@samsung.com>
References: <20100525044214.GE7248@trinity.fluff.org>
	<004b01cafbce$7b249430$716dbc90$%kim@samsung.com>
Message-ID: <20100525073124.GA11051@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 02:52:29PM +0900, Kukjin Kim wrote:
> Ben Dooks wrote:
> > 
> > Thankyou to all who contributed to this round of updates, I am officially
> > calling the end of any new development work for this merge window.
> > 
> > Special thanks to all at Samsung for their help.
> > 
> > I will now be preparing a defconfig, documentation and any other bugfixes
> > tree to send to Linus as soon as possible.
> > 
> > As a note, this is the shortlog of the patches merged via my tree:
> 
> Thanks for your review and merging.
> 
> And ok, we will continue our development and submit patches for the next
> merge window. Also, if we find any issues, we will submit patches for those
> also.

The impression I have is that Samsung folk waited for the merge window
before sending their patches to the mailing list - there have been
about 320 messages attributable to 'samsung' or 's3' subjects since the
merge window opened.

This is excessive, and isn't really practical - it swamps the mailing
list and makes it very easy to miss more relevant stuff during the
merge window.

So, please send the majority of patches *before* the merge window and
try to avoid sending anything but fixes during the merge window itself.
The merge window is for code which has _already_ been merged and has
been in linux-next to be merged into Linus' tree.  It's not for new
code to be reviewed.

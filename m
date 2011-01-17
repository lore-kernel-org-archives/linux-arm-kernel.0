From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 10:46:18 +0000
Subject: [RFC+CFT] Use word operations in bitops
In-Reply-To: <20110117100857.GS6917@pengutronix.de>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
	<20110117100857.GS6917@pengutronix.de>
Message-ID: <20110117104618.GB18626@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 11:08:57AM +0100, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> On Sun, Jan 16, 2011 at 12:19:11PM +0000, Russell King - ARM Linux wrote:
> > This does need a fair amount of testing before it can be merged, so I'd
> > like to see a number of Tested-by's against this patch.  Please also
> > indicate whether you tested on LE or BE or both, which filesystems, and
> > whether they were read-only mounted or read-write mounted.
> You could make life a bit easier (at least for us at Pengutronix,
> probably more) if you had a branch with a defined name for patches like
> these.  We could add that to our daily test then.

No, because then it's not possible to properly tie down what has been
tested and what hasn't.

The advantage of emailed patches is that when people reply to them, you
have a better idea that the patch to which they're replying to is the
one they tested.

Such as in this case where the follow-up patch hasn't received any
replies, and so I can't add the one received tested-by to the follow-up
patch.  With the git approach, I wouldn't know what was tested unless
you included the commit IDs each time.

And let's face it - if it was tested daily, are you going to go through
the hastle of digging out the commit IDs and emailing each day to say
what was tested?  That sounds to me like a _lot_ more work than testing
the occasional emailed patch.

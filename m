From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 17 Jan 2011 11:08:57 +0100
Subject: [RFC+CFT] Use word operations in bitops
In-Reply-To: <20110116121911.GB27542@n2100.arm.linux.org.uk>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
Message-ID: <20110117100857.GS6917@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sun, Jan 16, 2011 at 12:19:11PM +0000, Russell King - ARM Linux wrote:
> This does need a fair amount of testing before it can be merged, so I'd
> like to see a number of Tested-by's against this patch.  Please also
> indicate whether you tested on LE or BE or both, which filesystems, and
> whether they were read-only mounted or read-write mounted.
You could make life a bit easier (at least for us at Pengutronix,
probably more) if you had a branch with a defined name for patches like
these.  We could add that to our daily test then.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

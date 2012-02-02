From: stigge@antcom.de (Roland Stigge)
Date: Thu, 02 Feb 2012 20:37:42 +0100
Subject: [PATCH] ARM: LPC32xx: Support for OHCI HCD
In-Reply-To: <20120202164114.GB3219@pengutronix.de>
References: <1328103028-20547-1-git-send-email-stigge@antcom.de>
 <20120202164114.GB3219@pengutronix.de>
Message-ID: <4F2AE606.7090903@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/02/2012 05:41 PM, Wolfram Sang wrote:
> Okay, I asked for a patch to test USB, so thanks. It did not work 
> for me, sadly, so there seems to be more work needed in that area.

Of course, we need to first sort things out. :-)

Already now, when you apply all my patches on top of each other, USB
(and ethernet) works fine for me.

Of course, the just re-posted base series ("v3") has priority, but if
you are curious, you can have a look at the patches at
http://antcom.de/lpc32xx/ and apply them on top of current mainline
(3.3-rc2). You need to manually enable OHCI and the LPC-ETH drivers,
based on our new defconfig, of course. If it still doesn't work,
please tell me at which point it doesn't compile or boot.

I just re-tested this with my PHYTEC3250 board, using NFS root and
mounting USB mass storage.

> also misses important mailing lists (usb).

I posted the drivers for ethernet, usb and iio to the respective
maintainers and mailing lists, separately.

> May I ask if you read Documentation/development-process and/or 
> Documentation/SubmittingPatches? If not, please do so.

Good. Thanks for the hint. :-)

We can do one step after another.

Thanks for your involvement here!

Roland

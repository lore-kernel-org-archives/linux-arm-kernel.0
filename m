From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Feb 2010 12:01:35 +0100
Subject: pull request for .34
In-Reply-To: <20100218102757.GA20243@n2100.arm.linux.org.uk>
References: <20100218101538.GA8659@pengutronix.de>
	<20100218102757.GA20243@n2100.arm.linux.org.uk>
Message-ID: <20100218110135.GB8659@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, Feb 18, 2010 at 10:27:57AM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 18, 2010 at 11:15:38AM +0100, Uwe Kleine-K?nig wrote:
> > I collected the raw_spinlock conversion patches by Thomas[1] and put them
> > together with my patches in my repository.
> 
> Thomas asked me about a pull request for his patches, and I said no
> because they're spread across many different mach-* directories.  So
> this isn't helpful.
Hmm, if this was on the list then sorry, I missed it.
 
> What also isn't helpful is bundling it up with
I just thought that I might make it easier for you.  And they are not
more bundled than in the case where you pull them together, are they?

>                                                the load address change
> stuff which I'm not pulling for .34.
That's the first objection I hear (or read) about that.  I'm not sure
what is meant by "load address change stuff", I assume it's the runtime
physoffset.  I look forward to more concrete feed-back.

>       arm/zImage: fix comments for cache_on, cache_off and cache_clean_flush
>       arm/zImage: some comments for __armv3_mpu_cache_on
>       arm/zImage: __armv3_mpu_cache_flush: respect should-be-zero specification
>       arm/zImage: annotate debug functions about corrupted registers
>       arm/zImage: don't define unused symbol initrd_phys
>       arm: deprecate support for old way to pass kernel parameters
>       arm/zImage: don't hard code the stack size twice
>       arm/uImage: require passing a LOADADDR when building with RUNTIME_PHYSOFFSET
>       arm: Allow PHYS_OFFSET to be runtime determined
>       arm: remove bit-rotten STANDALONE_DEBUG for decompressor
>       arm/ixp2000: fix type of ixp2000_timer_interrupt
Is it OK for you to take all but the two concering RUNTIME_PHYSOFFSET?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

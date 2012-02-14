From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Feb 2012 13:01:43 -0800
Subject: [PATCH] modpost: Fix section warnings for ARM for many compilers
In-Reply-To: <20120214011228.GM1426@atomide.com>
References: <20120213212401.GH1426@atomide.com>
 <20120213222652.GL14173@pengutronix.de>
 <20120213225118.GC31482@n2100.arm.linux.org.uk>
 <878vk6cl5z.fsf@rustcorp.com.au>
 <20120214011228.GM1426@atomide.com>
Message-ID: <20120214210143.GW1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120213 16:41]:
> * Rusty Russell <rusty@rustcorp.com.au> [120213 16:07]:
> > On Mon, 13 Feb 2012 22:51:18 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > > On Mon, Feb 13, 2012 at 11:26:52PM +0100, Uwe Kleine-K?nig wrote:
> > > > On Mon, Feb 13, 2012 at 01:24:01PM -0800, Tony Lindgren wrote:
> > > > Maybe:
> > > > 
> > > > #ifndef R_ARM_CALL
> > > > #warning "you're elf.h include is outdated"
> > > 
> > > "You are elf.h include is outdated" does not make sense.
> > > 
> > > Why are you calling Tony an elf.h include?
> > 
> > Because he knew it would attract the attention of pedants to the patch?
> > :)
> 
> I've been called worse than that :)
>  
> > Just do the #ifndef, and skip the warning.  There's not much the poor
> > user receiving the warning can do about it.
> 
> OK
>  
> > Acked-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Assuming your ack applies for this patch below, let me know if that's
> not the case.  

This is now in Russell's patch tracking system as patch 7324/1.

Tony

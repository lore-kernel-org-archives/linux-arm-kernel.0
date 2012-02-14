From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 14 Feb 2012 10:59:12 +1030
Subject: [PATCH] modpost: Fix section warnings for ARM for many compilers
In-Reply-To: <20120213225118.GC31482@n2100.arm.linux.org.uk>
References: <20120213212401.GH1426@atomide.com>
 <20120213222652.GL14173@pengutronix.de>
 <20120213225118.GC31482@n2100.arm.linux.org.uk>
Message-ID: <878vk6cl5z.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Feb 2012 22:51:18 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Feb 13, 2012 at 11:26:52PM +0100, Uwe Kleine-K?nig wrote:
> > On Mon, Feb 13, 2012 at 01:24:01PM -0800, Tony Lindgren wrote:
> > Maybe:
> > 
> > #ifndef R_ARM_CALL
> > #warning "you're elf.h include is outdated"
> 
> "You are elf.h include is outdated" does not make sense.
> 
> Why are you calling Tony an elf.h include?

Because he knew it would attract the attention of pedants to the patch?
:)

Just do the #ifndef, and skip the warning.  There's not much the poor
user receiving the warning can do about it.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks,
Rusty.

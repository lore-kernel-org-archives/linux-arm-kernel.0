From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jul 2010 13:57:09 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007231218.07379.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
	<201007231218.07379.david.jander@protonic.nl>
Message-ID: <20100723125709.GA750@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 12:18:07PM +0200, David Jander wrote:
> Then why can't they get the boot-loader fixed?

You're asking the WRONG people.

> Clarification: Amateuristish was meant as much or even more for 
> hardware/bootloader development as for the kernel part. Don't just feel 
> offended, but you can't tell me that delivering hardware with a half-baked 
> bootloader to a kernel developer and letting him hack/guess the I/O 
> initialization together that the boot-loader got wrong doesn't sound very 
> professional to me.

To make the same point yet again: I would like a working boot loader
for one of my boards, so that I can use it productively.  Despite
asking for one, I've still to receive such a thing.

So, you can call one of the largest silicon manufacturers on the planet
"amateurish" if you wish... that's not going to make them change.

Now, there's little point continuing to discuss this - we've made the
situation plainly clear to you, and also pointed out that it's out of
our control.  So what's the point in continuing to tell us that we're
doing it all wrong?

Please, talk to the people who do boot loaders about your issues with
their code, rather than the people who have to live with the crap produced
by those people.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 10:02:26 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <AANLkTinxKrFdYxfr2X1y9Tkivo3t9Ahz2hNMQDtD7emb@mail.gmail.com>
References: <201007211029.29529.david.jander@protonic.nl>
	<20100721084726.GC6009@n2100.arm.linux.org.uk>
	<20100722023250.GC27663@verge.net.au>
	<20100722072034.GA6802@n2100.arm.linux.org.uk>
	<20100722072948.GA7101@verge.net.au>
	<AANLkTilA-9ZjAVqiql1amjjrRlh724z_RHQz7VBdNSxA@mail.gmail.com>
	<AANLkTinxKrFdYxfr2X1y9Tkivo3t9Ahz2hNMQDtD7emb@mail.gmail.com>
Message-ID: <20100722090226.GM6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 10:49:14AM +0200, Eric Miao wrote:
> I agree with Magnus, that kernel as a bootloader is a good idea to go.
> 
> And the kexecboot works awesome on my zaurus, I like that very much
> instead of flashing my device with a series of awkward steps.

Yes, it can be nice (it's been around for over ten years now) - but
what I'm saying is that if you have this stuff in the kernel already,
and the kernel knows what platform you're on...

Well, you know this because PXA is one of the platforms which handles
pin muxing really well.

Let's not get distracted by the issue of eliminating the boot loader -
the original email in this thread was basically asking "why do we have
pin mux code in both boot loaders and the kernel" which has already
been answered several times over.

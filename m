From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 08:20:34 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <20100722023250.GC27663@verge.net.au>
References: <201007211029.29529.david.jander@protonic.nl>
	<20100721084726.GC6009@n2100.arm.linux.org.uk>
	<20100722023250.GC27663@verge.net.au>
Message-ID: <20100722072034.GA6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 11:32:53AM +0900, Simon Horman wrote:
> Would it be feasible to  use Linux + kexec as the boot loader as
> a long term solution to fixing boot loaders by eliminating them?

So what you're proposing is that a broken boot loader should boot a
version of Linux to fix the pin MUX, which then kexecs a kernel which
doesn't have that code?

What's the point of that - when the first kernel will be able to run
the system?

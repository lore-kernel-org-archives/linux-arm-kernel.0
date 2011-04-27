From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 21:52:16 +0100
Subject: About enable L2 cache in Linux kernel
In-Reply-To: <BANLkTinTB=BmybmAGCRAbS9+nsLbXwBvkg@mail.gmail.com>
References: <BANLkTinTB=BmybmAGCRAbS9+nsLbXwBvkg@mail.gmail.com>
Message-ID: <20110427205216.GC17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 11:37:28AM +0800, Jason Liu wrote:
> I notice that if bootloader does not enable L2, after linux boot up,
> the L2 cached will keep disabled.
> Do you know why Linux kernel does not do L2 cache enable operation at
> start up on cortex_a8?

No idea.

We do have code which enables a PL2x0 cache controller if the platform
calls the relevant function.  I don't know off-hand what's fitted inside
your SoC to comment further though.

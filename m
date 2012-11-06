From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 6 Nov 2012 22:51:05 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211051908.34291.arnd@arndb.de>
 <20121106122011.GE29853@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
 <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
Message-ID: <20121106225105.GD10187@jl-vm1.vm.bytemark.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> I really think that it makes no sense at all to support !MMU kernels in 
> a multi-platform kernel build, even if the set of included platforms 
> were all !MMU.  The kernel has to be linked for the physical address of 
> the target and not a common invariant virtual address.

Although there's likely to be approximately zero interest in
multi-platform !MMU, relocating at boot time doesn't sound onerous,
should it be needed.  x86 kernels already do that.  Maybe ARM kernels
will eventually do that anyway for the same reason as x86.

-- Jamie

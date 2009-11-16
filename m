From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2009 10:53:25 +0000
Subject: [GIT PULL] Patches for 2.6.33
In-Reply-To: <1258367694.6705.16.camel@pc1117.cambridge.arm.com>
References: <1258367694.6705.16.camel@pc1117.cambridge.arm.com>
Message-ID: <20091116105325.GA27894@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 10:34:54AM +0000, Catalin Marinas wrote:
> Catalin Marinas (3):
>       Fix the machine description printing in __error_a

I think you can drop this one - doesn't 158bc5a cover it?

>       Add an earlyprintk debug console
>       ARMv7: Use lazy cache flushing if hardware broadcasts cache operations

I'm holding off on this - I think I have something similar in smp_plat.h
in my git tree, and I don't remember whether that stuff has been sent to
the list as part of my previous patch dump.

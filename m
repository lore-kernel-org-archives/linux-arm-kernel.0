From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Apr 2010 16:40:53 +0100
Subject: Decompression failure in an inexplicable case
In-Reply-To: <A809F2C8-74CA-474E-92B0-08A5227B7C3F@prograde.net>
References: <A809F2C8-74CA-474E-92B0-08A5227B7C3F@prograde.net>
Message-ID: <1272555653.15152.3.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-04-29 at 16:27 +0100, Michael Cashwell wrote:
> If I omit CPUFreq support [CONFIG_CPU_FREQ is not set], or enable both
> it and its debugging support [CONFIG_CPU_FREQ_DEBUG=y], the kernel
> builds and runs seemingly fine.
> 
> But if I have CONFIG_CPU_FREQ enabled but NOT its debugging support
> then kernel builds OK (including full mrproper cleanings in between):

I had some issues a few weeks ago with the decompressing:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/73476

That seemed to do with the size of the Image file and randomly removing
parts of it made it work. Unfortunately, I couldn't reproduce it so that
others can try.

-- 
Catalin

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 17:46:52 +0200
Subject: [PATCH 08/37] ARM: mach-omap2: remove mach/memory.h
In-Reply-To: <alpine.LFD.2.00.1107071113410.14596@xanadu.home>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
	<201107071708.36668.arnd@arndb.de>
	<alpine.LFD.2.00.1107071113410.14596@xanadu.home>
Message-ID: <201107071746.52845.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011, Nicolas Pitre wrote:
> The only reason why you might want to use a build time PHYS_OFFSET at 
> that point is for running the kernel XIP in ROM, or if you have very 
> special requirements.  And for that you really must know what you're 
> doing.  Some people have indicated that CONFIG_XIP_KERNEL is still 
> useful for them.  So I left the ability there to preserve some 
> flexibility, otherwise I probably would have made ARM_PATCH_PHYS_VIRT 
> unconditional in that case.

Ok, fair enough.

	Arnd

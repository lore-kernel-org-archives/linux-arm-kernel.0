From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 2 Apr 2011 06:38:04 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <alpine.LFD.2.00.1104011557080.28032@xanadu.home>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104011554.07924.arnd@arndb.de>
	<1301671655.28467.52.camel@e102144-lin.cambridge.arm.com>
	<201104011755.57412.arnd@arndb.de>
	<alpine.LFD.2.00.1104011557080.28032@xanadu.home>
Message-ID: <20110402043804.GB3989@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2011 at 04:19:31PM -0400, Nicolas Pitre wrote:
> 
> In a perfect world the bootloader would be bug free and always up to 
> date with the best DT data.  In practice I'm very skeptical this will 
> always be the case and painless.  At least the above makes it very 
> simple to have a self contained kernel when (not if) need be.

Yes, my experience with DT on powerpc teaches me that, although DT
sounds wonderful in theory, in practice kernel/dtb/uboot form a love
triangle (or perhaps a hate triangle) where all three points must be
exactly up to date with each other. If one part is even just a month
or two too old/new, then your kernel might not boot.

Richard

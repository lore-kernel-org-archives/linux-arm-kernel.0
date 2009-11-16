From: kevin.wells@nxp.com (Kevin Wells)
Date: Mon, 16 Nov 2009 18:23:36 +0100
Subject: submitting new ARM platforms
Message-ID: <083DF309106F364B939360100EC290F804F54660B1@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(Sorry if this message shows up twice!)

We are the process of getting Linux optimized to the NXP LPC32X0 SoC and would
like to get the files submitted for inclusion into the mainline. Currently, this
consists of 4 CPU variants (all very similar) and 3 different boards (all very
different!).

The kernel and most of the drivers have been ported to this board for about a
year now, with occasional tweaks needed as the kernel version progresses. A
number of developers are using the kernel on these boards now. We are getting
a lot of requests to get this into mainline!

I don't want to deluge everyone or anyone all at once, but would like to get
this started!

Most of the work for this is already done up to 2.6.32-rc6. Whats the best
approach to get started here? I would like to start small with just the basic
arch files with 1 or 2 boards and later add in the other support as more of the
optimzied chip specific drivers are merged in. As of now, the only change
required ouside of the existing kernel source tree is the arch/arm/Kconfig and
arch/arm/Makefile files and the addition of the arch/arm/mach-lpc32xx/ subdir.

Should I start posting patches for the basic mach- area first?

thanks,
Kevin Wells
NXP Semiconductors

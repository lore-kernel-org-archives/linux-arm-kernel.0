From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 3 Dec 2009 03:57:08 -0700 (MST)
Subject: [PATCH 8/8] OMAP1 clock: convert mach-omap1/clock.h to
	mach-omap1/clock_data.c
In-Reply-To: <20091203104354.GB20379@n2100.arm.linux.org.uk>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
	<20091203100707.1203.98247.stgit@localhost.localdomain>
	<20091203102700.GA30423@flint.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com>
	<20091203104354.GB20379@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.0912030355050.13408@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, 3 Dec 2009, Russell King - ARM Linux wrote:

> You say this, but you're keeping the associated code around as well
> which is pointless.

Could you elaborate?

> You also say about polluting the symbol table unnecessarily.  What
> about the pollution caused by having two (or more) functions made
> public rather than just one data structure?

Good point.  Will move the clkops structures to the appropriate clock.c 
files, and mark the functions static.


- Paul

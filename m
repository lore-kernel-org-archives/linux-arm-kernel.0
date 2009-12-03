From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 3 Dec 2009 08:26:55 -0700 (MST)
Subject: [PATCH v2 8/8] OMAP1 clock: convert mach-omap1/clock.h to
	mach-omap1/clock_data.c
In-Reply-To: <20091203150300.GB26651@n2100.arm.linux.org.uk>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
	<20091203100707.1203.98247.stgit@localhost.localdomain>
	<20091203102700.GA30423@flint.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com>
	<20091203104354.GB20379@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030355050.13408@utopia.booyaka.com>
	<alpine.DEB.2.00.0912030424050.13408@utopia.booyaka.com>
	<20091203121157.GC20379@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030520360.13408@utopia.booyaka.com>
	<20091203150300.GB26651@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.0912030822060.13408@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, 3 Dec 2009, Russell King - ARM Linux wrote:

> On Thu, Dec 03, 2009 at 05:33:44AM -0700, Paul Walmsley wrote:
> > My preference was to keep data separated from code in the source files; I 
> > think it is slightly more readable.
> 
> It's less readable because instead of having similar stuff together, it's
> at opposite ends of the file.

Okay.  Our opinions differ.  I'm happy to make this change to align it 
with what you like.


- Paul

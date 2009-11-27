From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 27 Nov 2009 15:48:56 -0500 (EST)
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <20091127200521.GC28193@n2100.arm.linux.org.uk>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<FCBE654890C0334289D0AD3AF4EF009F89684D7F09@IL-MB01.marvell.com>
	<20091127200521.GC28193@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0911271547110.2059@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Nov 2009, Russell King - ARM Linux wrote:

> On Wed, Nov 25, 2009 at 12:28:42AM +0200, Saeed Bishara wrote:
> >     For some reason, my previous email didn't reach the mailing list.
> >     Here is the patch as an attachment with some minor updates (replaced
> > mach/gpio.h to linux/gpio.h)
> 
> Also #include <asm/io.h> and (any) #include <mach/io.h> -> linux/io.h please.

I amended the orion Git repository directly to fix those.


Nicolas

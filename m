From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Feb 2011 15:35:49 -0500 (EST)
Subject: [PATCH] ARM: Thumb-2: Reflect ARM/Thumb-2 configuration in module
	vermagic
In-Reply-To: <20110222202514.GC29559@n2100.arm.linux.org.uk>
References: <1298382538-15682-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1102221502160.14920@xanadu.home>
	<20110222202514.GC29559@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102221534490.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Feb 2011, Russell King - ARM Linux wrote:

> On Tue, Feb 22, 2011 at 03:03:46PM -0500, Nicolas Pitre wrote:
> > On Tue, 22 Feb 2011, Dave Martin wrote:
> > 
> > > Loading Thumb-2 modules into an ARM kernel or vice-versa isn't
> > > guaranteed to work safely, since the kernel is not interworking-
> > > aware everywhere.
> > 
> > Too bad.
> > 
> > > This patch adds "thumb2" to the module vermagic when
> > > CONFIG_THUMB2_KERNEL is enabled, to help avoid accidental loading
> > > of modules into the wrong kernel.
> > > 
> > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > 
> > Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Lets wait until after the next merge window has gone, or let's have a
> patch which takes account of stuff already merged.  Either way, there
> little point acking it as it needs an effective rewrite to fit around
> the P2V changes to this file.

It certainly can be made to apply on top of your p2v-stable branch.


Nicolas

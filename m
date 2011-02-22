From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Feb 2011 20:25:14 +0000
Subject: [PATCH] ARM: Thumb-2: Reflect ARM/Thumb-2 configuration in
	module vermagic
In-Reply-To: <alpine.LFD.2.00.1102221502160.14920@xanadu.home>
References: <1298382538-15682-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1102221502160.14920@xanadu.home>
Message-ID: <20110222202514.GC29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 03:03:46PM -0500, Nicolas Pitre wrote:
> On Tue, 22 Feb 2011, Dave Martin wrote:
> 
> > Loading Thumb-2 modules into an ARM kernel or vice-versa isn't
> > guaranteed to work safely, since the kernel is not interworking-
> > aware everywhere.
> 
> Too bad.
> 
> > This patch adds "thumb2" to the module vermagic when
> > CONFIG_THUMB2_KERNEL is enabled, to help avoid accidental loading
> > of modules into the wrong kernel.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Lets wait until after the next merge window has gone, or let's have a
patch which takes account of stuff already merged.  Either way, there
little point acking it as it needs an effective rewrite to fit around
the P2V changes to this file.

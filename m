From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 10 Aug 2012 10:59:11 +0100
Subject: [PATCH 04/10] ARM: pass -marm to gcc by default
In-Reply-To: <alpine.LFD.2.02.1208091721460.5231@xanadu.home>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
 <1344461278-28245-5-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.02.1208091709010.5231@xanadu.home>
 <20120809211717.GW18957@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1208091721460.5231@xanadu.home>
Message-ID: <20120810095911.GA2157@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 05:22:30PM -0400, Nicolas Pitre wrote:
> On Thu, 9 Aug 2012, Russell King - ARM Linux wrote:
> 
> > On Thu, Aug 09, 2012 at 05:12:58PM -0400, Nicolas Pitre wrote:
> > > CFLAGS_THUMB2 should probably be renamed to something more appropriate 
> > > in this case, e.g. CFLAGS_MODE.
> > 
> > CFLAGS_ISA would be more relevant to it, because it's selecting the
> > instruction set.
> 
> Agreed.  This particular TLA escaped my mind somehow.

Seems fair enough.  It doesn't quite match the official architectural
terminology, but it clear enough what it means, and less cumbersome than
the alternatives.

Best not to use MODE though.  That word is way too overloaded.

---Dave

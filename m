From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Aug 2012 22:17:17 +0100
Subject: [PATCH 04/10] ARM: pass -marm to gcc by default
In-Reply-To: <alpine.LFD.2.02.1208091709010.5231@xanadu.home>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
 <1344461278-28245-5-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.02.1208091709010.5231@xanadu.home>
Message-ID: <20120809211717.GW18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 05:12:58PM -0400, Nicolas Pitre wrote:
> CFLAGS_THUMB2 should probably be renamed to something more appropriate 
> in this case, e.g. CFLAGS_MODE.

CFLAGS_ISA would be more relevant to it, because it's selecting the
instruction set.

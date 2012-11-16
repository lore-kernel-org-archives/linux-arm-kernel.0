From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Nov 2012 11:38:40 +0000
Subject: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
In-Reply-To: <50A6119E.8010303@atmel.com>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
 <20121116095352.GF4398@game.jcrosoft.org> <50A6119E.8010303@atmel.com>
Message-ID: <20121116113840.GQ3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 11:12:46AM +0100, Nicolas Ferre wrote:
> On 11/16/2012 10:53 AM, Jean-Christophe PLAGNIOL-VILLARD :
> > On 10:36 Fri 21 Sep     , Russell King wrote:
> >> The definitions provided by serial_at91.h are only used by the
> >> atmel_serial driver, and the function that uses it is never called
> >> from anywhere in the kernel.  Therefore, these definitions are unused
> >> and/or obsolete, and can be removed.
> >>
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > personnaly I'm ok with it too
> > Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > 
> > but Andrew seems use it so let him reply
> 
> Yes, during previous attempt to remove the files, Andrew said that it
> was used internally in his former company. I had no serious reason to
> remove it, so we kept it back then.
> But now it seems the situation has evolved and we must consider the move
> to a single kernel image and the will to clean the include/asm/mach
> directory.
> 
> So, now, on my side:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks for reminding me about this series, I'd completely forgotten about
it.  It'll be in the next linux-next tree now.

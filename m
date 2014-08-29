From: balbi@ti.com (Felipe Balbi)
Date: Fri, 29 Aug 2014 10:55:51 -0500
Subject: [PATCH 15/15] tty: serial: 8250: omap: add dma support
In-Reply-To: <540048B4.7010807@linutronix.de>
References: <20140815210211.GD9239@atomide.com>
 <53F5AF0D.5060409@linutronix.de>
 <20140821184416.GF10066@atomide.com>
 <53FE3779.5090908@linutronix.de>
 <20140827202313.GF16006@atomide.com>
 <20140828082348.GA5413@linutronix.de>
 <20140828164645.GG16006@atomide.com>
 <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
Message-ID: <20140829155551.GD2620@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 11:32:36AM +0200, Sebastian Andrzej Siewior wrote:
> On 08/29/2014 12:54 AM, Tony Lindgren wrote:
> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140828 12:37]:
> >> On 08/28/2014 06:46 PM, Tony Lindgren wrote:
> >>>
> >>> Sounds like there should be some way to clear that state.. I wonder
> >>> if omap-serial.c had something before it's DMA support was removed?
> >>
> >> Its DMA was removed? Like there was DMA support?
> > 
> > Yeah see commit 494574304711a333386e7dd5fd3ebbc3b7024994...
> 
> Interesting. I've been browsing that file and checking other trees and
> never noticed that it was there at some point. I only saw the pieces
> which looked it was there.

it was known to be broken and unused. There was no way to even enable
that code.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/9b1134fd/attachment.sig>

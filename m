From: balbi@ti.com (Felipe Balbi)
Date: Thu, 19 Mar 2015 13:50:54 -0500
Subject: [PATCH 10/13] usb: gadget: atmel_usba: use endian agnostic IO on
 ARM
In-Reply-To: <550AFD77.1080901@atmel.com>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-11-git-send-email-ben.dooks@codethink.co.uk>
 <550AFD77.1080901@atmel.com>
Message-ID: <20150319185054.GE13793@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 05:46:47PM +0100, Nicolas Ferre wrote:
> Le 18/03/2015 16:53, Ben Dooks a ?crit :
> > Change from using the __raw IO accesors to the endian agnostic versions
> > of readl/writel_relaxed when not on AVR32. This fixes issues with running
> > big endian on ARMv7.
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > --
> > CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Felipe, for the record:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

sorry, it's already in my immutable branch :-(

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150319/a59bf650/attachment.sig>

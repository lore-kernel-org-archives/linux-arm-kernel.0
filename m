From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 27 Jan 2012 23:32:11 +0100
Subject: [PATCH] Fix LPC32XX's clock.c
In-Reply-To: <1327673868-19741-1-git-send-email-stigge@antcom.de>
References: <1327673868-19741-1-git-send-email-stigge@antcom.de>
Message-ID: <20120127223211.GA27425@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 03:17:48PM +0100, Roland Stigge wrote:
> * Forward-ported LPC32XX's clock.c from git.lpclinux.com
> * Added MLC NAND and ADC clock
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

This needs to be split up further to make reviewing easier, I'd say. From a
glimpse, I'd guess:

- locking changes
- usb fixes
- adding MLC NAND
- adding ADC

I dunno, maybe the NXP git has the incremental changes? You should really CC
Kevin Wells on your patches. Maybe he will wake up again, at least with some
additional informaition.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120127/3a0f9939/attachment.sig>

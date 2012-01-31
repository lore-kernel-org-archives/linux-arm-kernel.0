From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 11:22:49 +0100
Subject: [PATCH v2 1/7] LPC32xx: clock.c: Missing header file
In-Reply-To: <4F26D9DC.2000008@ru.mvista.com>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
 <4F26D9DC.2000008@ru.mvista.com>
Message-ID: <20120131102249.GF2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 08:56:44PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/30/2012 07:02 PM, Roland Stigge wrote:
> 
> >This patch fixes the compiler warnings regarding the EXPORT_SYMBOL usage
> 
> >Signed-off-by: Roland Stigge<stigge@antcom.de>
> 
> >diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
> >index 1e02751..8e79313 100644
> >--- a/arch/arm/mach-lpc32xx/clock.c
> >+++ b/arch/arm/mach-lpc32xx/clock.c
> >@@ -82,6 +82,7 @@
> >   *   will also impact the individual peripheral rates.
> >   */
> >
> >+#include<linux/module.h>
> 
>    Shouldn't <linux/export.h> be included instead nowadays?

Ack.

@Roland: Nice series, thanks for splitting things up.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/4e4f30cc/attachment.sig>

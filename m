From: balbi@ti.com (Felipe Balbi)
Date: Mon, 12 Aug 2013 13:08:51 -0500
Subject: [PATCH] usb: gadget: at91_udc: add usb_clk for transition to
 common clk framework
In-Reply-To: <5208E881.3030205@atmel.com>
References: <1375337885-2684-1-git-send-email-b.brezillon@overkiz.com>
 <5208E881.3030205@atmel.com>
Message-ID: <20130812180851.GF27954@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 03:52:01PM +0200, Nicolas Ferre wrote:
> On 01/08/2013 08:18, Boris BREZILLON :
> >The AT91 PMC (Power Management Controller) provides an USB clock used by
> >USB Full Speed host (ohci) and USB Full Speed device (udc).
> >The usb drivers (ohci and udc) must configure this clock to 48Mhz.
> >This configuration was formely done in mach-at91/clock.c, but this
> >implementation will be removed when moving to common clk framework.
> >
> >This patch adds support for usb clock retrieval and configuration, and is
> >backward compatible with the current at91 clk implementation (if usb clk
> >is not found, it does not configure/enable it).
> >
> >Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I don't have the original, where is it ? Was it not Cced to linux-usb ?
Can someone resend with Nicolas' Acked-by in place ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/5aa45466/attachment.sig>

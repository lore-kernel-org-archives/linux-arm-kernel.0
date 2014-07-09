From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 9 Jul 2014 09:26:45 +0200
Subject: [PATCH 2/2] usb: ci_hdrc_imx doc: fsl,usbphy is required
In-Reply-To: <53BC1C4B.6060207@cogentembedded.com>
References: <1404814481-7652-1-git-send-email-mpa@pengutronix.de>
 <1404814481-7652-2-git-send-email-mpa@pengutronix.de>
 <53BC1C4B.6060207@cogentembedded.com>
Message-ID: <20140709072645.GI6633@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 08, 2014 at 08:28:59PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07/08/2014 02:14 PM, Markus Pargmann wrote:
> 
> >fsl,usbphy is no optional property. This patch moves it to the list of
> >required properties.
> 
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >---
> >  Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> >diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
> >index a6a32cb7f777..8014d0d050f8 100644
> >--- a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
> >+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
> >@@ -4,6 +4,7 @@ Required properties:
> >  - compatible: Should be "fsl,imx27-usb"
> >  - reg: Should contain registers location and length
> >  - interrupts: Should contain controller interrupt
> >+- fsl,usbphy: phandler of usb phy that connects to the only one port
> 
>    s/phandler/phandle/. Can fix, while at it...

Yes, right, I will fix it and resend.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/27181e9e/attachment.sig>

From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 28 Oct 2013 10:00:01 +0800
Subject: [PATCH v3 4/5] usb: doc: chipidea: imx: add compatiable string
 for imx28 SoC
In-Reply-To: <201310271726.17055.marex@denx.de>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
 <1382680943-9258-4-git-send-email-peter.chen@freescale.com>
 <201310271726.17055.marex@denx.de>
Message-ID: <20131028020000.GC31499@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 05:26:16PM +0100, Marek Vasut wrote:
> Dear Peter Chen,
> 
> > Due to imx28 usb has special write requirement compared to other imx SoCs.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> > Changes for v3:
> > - 4/5, 5/5 are added
> > 
> >  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt index
> > b4b5b79..a502d41 100644
> > --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > @@ -1,7 +1,8 @@
> >  * Freescale i.MX ci13xxx usb controllers
> > 
> >  Required properties:
> > -- compatible: Should be "fsl,imx27-usb"
> > +- compatible: "fsl,imx28-usb" for imx28 SoC, "fsl,imx27-usb" for
> > +non-imx28 SoC.
> >  - reg: Should contain registers location and length
> >  - interrupts: Should contain controller interrupt
> 
> Does the ERRATA apply to MX23 as well btw?
> 

It is for i.mx28 only.

-- 

Best Regards,
Peter Chen

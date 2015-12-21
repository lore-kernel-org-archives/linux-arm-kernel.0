From: horms@verge.net.au (Simon Horman)
Date: Mon, 21 Dec 2015 15:34:48 +1100
Subject: [PATCH 3/3] ARM: shmobile: r8a7794: use fallback usbhs
 compatibility string
In-Reply-To: <CAMuHMdVAPYj5X4uF4vgfufnVToywBEAj9mwAgz0VQauUCB6m=Q@mail.gmail.com>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
 <1450404705-5449-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVAPYj5X4uF4vgfufnVToywBEAj9mwAgz0VQauUCB6m=Q@mail.gmail.com>
Message-ID: <20151221043447.GF14422@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:16:11AM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 18, 2015 at 3:11 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > --- a/arch/arm/boot/dts/r8a7794.dtsi
> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
> > @@ -724,7 +724,7 @@
> >         };
> >
> >         hsusb: usb at e6590000 {
> > -               compatible = "renesas,usbhs-r8a7794";
> > +               compatible = "renesas,usbhs-r8a7794", "renesas,usbhs";
> 
> "renesas,rcar-gen2-usbhs", not "renesas,usbhs".
> 
> (no complaints from checkpatch.pl?)

Silly me, I will fix that.

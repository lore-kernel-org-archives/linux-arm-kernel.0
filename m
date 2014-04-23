From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 23 Apr 2014 09:18:13 +0200
Subject: [PATCH 22/33] ARM: shmobile: Use r8a7740 suffix for i2c, mmcif,
 fsi2 compat strings
In-Reply-To: <CAMuHMdUA+wJmgn0P_q38ri7_TAq7zha-ekSUrvdpntG5gFv56Q@mail.gmail.com>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
 <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
 <CAMuHMdUA+wJmgn0P_q38ri7_TAq7zha-ekSUrvdpntG5gFv56Q@mail.gmail.com>
Message-ID: <20140423071813.GA2777@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 09:09:49AM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 23, 2014 at 3:25 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Ulrich Hecht <ulrich.hecht@gmail.com>
> >
> > Add "renesas,*-r8a7740" to the compatible strings for consistency with other
> > devices.
> 
> > diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> > index 8280884..9f65986 100644
> > --- a/arch/arm/boot/dts/r8a7740.dtsi
> > +++ b/arch/arm/boot/dts/r8a7740.dtsi
> > @@ -126,7 +126,7 @@
> 
> > -               compatible = "renesas,rmobile-iic";
> > +               compatible = "renesas,iic-r8a7740", "renesas,rmobile-iic";
> 
> I see an opportunity for improvement here: this driver doesn't seem to have
> any bindings documented under Documentation/devicetree/bindings/?

I am brushing up this driver currently, so consider it done. Just
waiting for a minor email issue to be solved before I can send out
patches.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/e74139b3/attachment.sig>

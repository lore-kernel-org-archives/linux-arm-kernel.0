From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Mar 2014 17:25:10 +0100
Subject: [PATCH V3 06/12] ARM: shmobile: r7s72100: add scif nodes to dtsi
In-Reply-To: <1930280.sZNcfhZEL8@avalon>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <1394208048-32495-7-git-send-email-wsa@the-dreams.de>
 <1930280.sZNcfhZEL8@avalon>
Message-ID: <20140307162510.GF28943@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > diff --git a/arch/arm/boot/dts/r7s72100.dtsi
> > b/arch/arm/boot/dts/r7s72100.dtsi index 6af5c28c670e..d49afe30c1d7 100644
> > --- a/arch/arm/boot/dts/r7s72100.dtsi
> > +++ b/arch/arm/boot/dts/r7s72100.dtsi
> > @@ -23,6 +23,14 @@
> >  		i2c1 = &i2c1;
> >  		i2c2 = &i2c2;
> >  		i2c3 = &i2c3;
> > +		serial0 = &scif0;
> > +		serial1 = &scif1;
> > +		serial2 = &scif2;
> > +		serial3 = &scif3;
> > +		serial4 = &scif4;
> > +		serial5 = &scif5;
> > +		serial6 = &scif6;
> > +		serial7 = &scif7;
> 
> As port usages is board specific, shouldn't this be moved to the board .dts 
> file, with only serial0 = &scif2 ?

Nope, the intention of these aliases is to have a consistent numbering
of SCIF cores, similar to platform.dev_id.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/81f203b1/attachment.sig>

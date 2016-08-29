From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 29 Aug 2016 14:56:37 +0000
Subject: [PATCH] ARM: dts: rskrza1: initial device tree
In-Reply-To: <CAMuHMdXmJPcgDcLkeVuF5YVfpwxRkJpACHGwtbNab18gK-nBbQ@mail.gmail.com>
References: <20160825153115.15291-1-chris.brandt@renesas.com>
 <CAMuHMdXmJPcgDcLkeVuF5YVfpwxRkJpACHGwtbNab18gK-nBbQ@mail.gmail.com>
Message-ID: <SG2PR06MB116594771BED3BAF944ECE298AE10@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Aug 29, Geert Uytterhoeven wrote:

> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
>
> > +       compatible = "renesas,rskrza1", "renesas,r7s72100";
>
> scripts/checkpatch.pl says:
>
>    DT compatible string "renesas,rskrza1" appears un-documented -- check ./Documentation/devicetree/bindings/
>
> Please send a follow-up patch to add this compatible value to Documentation/devicetree/bindings/arm/shmobile.txt.
>
> > +&scif2 {
> > +       status = "okay";
> > +};
> > +
>
> Please drop the trailing empty line.

Thank you for the review.
I will modify and resend.

Chris

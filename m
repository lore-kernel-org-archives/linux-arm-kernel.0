From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 9 Oct 2017 10:16:10 +0000
Subject: [PATCH ] phy: rcar-gen2: Add r8a7743/5 support
In-Reply-To: <535bd74a-ca7d-31bf-e7df-f2bda31be1a6@ti.com>
References: <1503568773-41410-1-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdW8x-7LVGgJr1GQfMJurfW=0Ky71K18zc+x5_XHMC6VxA@mail.gmail.com>
 <KL1PR06MB17020EBD5992AFA4F6E3F6C7B8740@KL1PR06MB1702.apcprd06.prod.outlook.com>
 <535bd74a-ca7d-31bf-e7df-f2bda31be1a6@ti.com>
Message-ID: <KL1PR06MB170203142C33A1733B89D3A5B8740@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks. I will resend the patch.

Regards,
Biju


> -----Original Message-----
> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
> Sent: 09 October 2017 10:47
> To: Biju Das <biju.das@bp.renesas.com>; Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Simon Horman <horms@verge.net.au>; Magnus
> Damm <magnus.damm@gmail.com>; Russell King <linux@armlinux.org.uk>;
> Chris Paterson <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org;
> Linux-Renesas <linux-renesas-soc@vger.kernel.org>; linux-arm-
> kernel at lists.infradead.org; Geert Uytterhoeven <geert@linux-m68k.org>
> Subject: Re: [PATCH ] phy: rcar-gen2: Add r8a7743/5 support
>
> Hi,
>
> On Monday 09 October 2017 02:19 PM, Biju Das wrote:
> > Hi Kishon,
> >
> > Looks like the below patch is not merged into linux-next.  Somehow I
> > missed your mail ID, when I submitted the
> > patch(scripts/get_maintainer.pl  script  didn't show your mail address
> > for this patch)
> >
> > https://patchwork.kernel.org/patch/9919727/
>
> Can you resend the patch with all the Ack's you got?
>
> Thanks
> Kishon
> >
> > Regards,
> > Biju
> >
> >
> >> -----Original Message-----
> >> From: geert.uytterhoeven at gmail.com
> >> [mailto:geert.uytterhoeven at gmail.com]
> >> On Behalf Of Geert Uytterhoeven
> >> Sent: 19 September 2017 15:58
> >> To: Biju Das <biju.das@bp.renesas.com>
> >> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> >> <mark.rutland@arm.com>; Simon Horman <horms@verge.net.au>; Magnus
> >> Damm <magnus.damm@gmail.com>; Russell King <linux@armlinux.org.uk>;
> >> Chris Paterson <Chris.Paterson2@renesas.com>;
> >> devicetree at vger.kernel.org; Linux-Renesas
> >> <linux-renesas-soc@vger.kernel.org>; linux-arm-
> >> kernel at lists.infradead.org
> >> Subject: Re: [PATCH ] phy: rcar-gen2: Add r8a7743/5 support
> >>
> >> On Thu, Aug 24, 2017 at 11:59 AM, Biju Das <biju.das@bp.renesas.com>
> >> wrote:
> >>> Add USB PHY support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5)
> >>> USB PHY is identical to the R-Car Gen2 family.
> >>>
> >>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> >>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> Gr{oetje,eeting}s,
> >>
> >>                         Geert
> >>
> >> --
> >> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> >> geert at linux- m68k.org
> >>
> >> In personal conversations with technical people, I call myself a
> >> hacker. But when I'm talking to journalists I just say "programmer" or
> something like that.
> >>                                 -- Linus Torvalds
> >
> >
> >
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End,
> Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered
> No. 04586709.
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

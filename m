From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Aug 2017 17:45:55 +0200
Subject: [PATCH 1/2] ARM: dts: iwg20d-q7: Add RTC support
In-Reply-To: <KL1PR06MB1702571F2F9B75205A11280AB88C0@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
 <1502197465-61546-2-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdUU5fb6G7Wc9ZzfFhLxcUuZFakPdVGh3q_cfUzxZ1AarA@mail.gmail.com>
 <KL1PR06MB1702571F2F9B75205A11280AB88C0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Message-ID: <20170815154555.GB26748@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 02:26:08PM +0000, Biju Das wrote:
> 
> 
> > -----Original Message-----
> > From: geert.uytterhoeven at gmail.com [mailto:geert.uytterhoeven at gmail.com]
> > On Behalf Of Geert Uytterhoeven
> > Sent: 14 August 2017 15:12
> > To: Biju Das <biju.das@bp.renesas.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Simon Horman <horms@verge.net.au>; Magnus
> > Damm <magnus.damm@gmail.com>; Russell King <linux@armlinux.org.uk>;
> > Chris Paterson <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org;
> > Linux-Renesas <linux-renesas-soc@vger.kernel.org>; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH 1/2] ARM: dts: iwg20d-q7: Add RTC support
> >
> > On Tue, Aug 8, 2017 at 3:04 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> > > Define the iWave RainboW-G20D-Qseven board dependent part of the RTC
> > > device node.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> >
> > > @@ -54,3 +59,16 @@
> > >                 micrel,led-mode = <1>;
> > >         };
> > >  };
> > > +
> > > +&i2c2 {
> > > +       pinctrl-0 = <&i2c2_pins>;
> > > +       pinctrl-names = "default";
> > > +
> > > +       status = "okay";
> > > +       clock-frequency = <400000>;
> > > +
> > > +       rtc at 68 {
> > > +               compatible = "bq32000";
> >
> > "ti,bq32000"
> 
> Thanks. I will change this.

Thanks, I have dropped this patch for now.
Please submit a v2.

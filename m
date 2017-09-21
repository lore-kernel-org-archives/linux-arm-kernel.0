From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Sep 2017 11:03:32 +0200
Subject: [PATCH 4/8] ARM: dts: iwg22d: Enable SDHI0 controller
In-Reply-To: <TY1PR06MB089549AB7DCF1C03605EF421C0660@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-5-git-send-email-chris.paterson2@renesas.com>
 <CAMuHMdVFPiXe9trwprNfX=p8-OKbrcgVSrwmveYhXGm=kd2bfQ@mail.gmail.com>
 <20170921083839.GH15749@verge.net.au>
 <20170921084219.GK15749@verge.net.au>
 <TY1PR06MB089549AB7DCF1C03605EF421C0660@TY1PR06MB0895.apcprd06.prod.outlook.com>
Message-ID: <20170921090332.GS15749@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 08:53:00AM +0000, Fabrizio Castro wrote:
> Hello Simon,
> 
> > -----Original Message-----
> > From: Simon Horman [mailto:horms at verge.net.au]
> > Sent: 21 September 2017 09:42
> > To: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > Magnus Damm <magnus.damm@gmail.com>; Russell King <linux@armlinux.org.uk>; Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com>; devicetree at vger.kernel.org; Linux-Renesas <linux-renesas-soc@vger.kernel.org>; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH 4/8] ARM: dts: iwg22d: Enable SDHI0 controller
> >
> > On Thu, Sep 21, 2017 at 10:38:40AM +0200, Simon Horman wrote:
> > > On Wed, Sep 20, 2017 at 01:40:20PM +0200, Geert Uytterhoeven wrote:
> > > > On Wed, Sep 13, 2017 at 7:05 PM, Chris Paterson
> > > > <chris.paterson2@renesas.com> wrote:
> > > > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > >
> > > > > Enable the SDHI0 controller on iWave RZ/G1E carrier board.
> > > > >
> > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > Thanks, applied.
> >
> > Sorry, I somehow overlooked Fabrizio's comments.
> > I have dropped this patch for now.
> 
> Thank you for doing this.
> We are working on a new patch now, I'll submit a V2 as soon as it is ready.
> Just to recap (all in one place), we found an HW issue and a SW one preventing SDHI0 from working properly at UHS SDR50 and SDR104, therefore we need a new patch to limit the speed of this interface.

Thanks for catching this, UHS can be quite troublesome in my experience.

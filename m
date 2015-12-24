From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Thu, 24 Dec 2015 20:41:54 +0000
Subject: [PATCH v3 2/2] dts/ls2080a: Update DTSI to add support of SP805
 WDT
In-Reply-To: <201512241118.32946.arnd@arndb.de>
References: <1450189825-29065-1-git-send-email-bhupesh.sharma@freescale.com>
 <1450189825-29065-3-git-send-email-bhupesh.sharma@freescale.com>
 <CAFTCetS7P6wF3MhgMSXSXP_jnLQvBc-NSY0TW3OOnCjtbL0N_w@mail.gmail.com>
 <201512241118.32946.arnd@arndb.de>
Message-ID: <BN3PR0301MB1298AF2C5A88FCA392D0E9DD82E70@BN3PR0301MB1298.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, December 24, 2015 3:49 PM
> To: Bhupesh SHARMA
> Cc: Sharma Bhupesh-B45370; Mark Rutland; linux-arm-
> kernel at lists.infradead.org; Olof Johansson; devicetree at vger.kernel.org;
> Rob Herring; Will Deacon; Catalin Marinas; Li Yang-Leo-R58472; Wood
> Scott-B07421; Yoder Stuart-B08248; shawn.guo at linaro.org
> Subject: Re: [PATCH v3 2/2] dts/ls2080a: Update DTSI to add support of
> SP805 WDT
> 
> On Wednesday 23 December 2015, Bhupesh SHARMA wrote:
> >
> > Hi Arnd, Olof, Kevin
> >
> > On Tue, Dec 15, 2015 at 8:00 PM, Bhupesh Sharma
> > <bhupesh.sharma@freescale.com> wrote:
> > > This patch updates the LS2080a DTSI (DTS Include) file to add
> > > support for eight SP805 Watchdog units which can be used to reset
> > > the eight Cortex-A57 cores available on LS2080A.
> > >
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   56
> ++++++++++++++++++++++++
> > >  1 file changed, 56 insertions(+)
> >
> > Since Rob has acked the SP805 WDT binding documentation patch (patch
> > 1/2 of this series),
> > can this DTSI change, please be considered for absorption in the arm-
> soc tree.
> 
> Sure, please submit it for inclusion. Who is the maintainer for
> arch/arm64/boot/dts/freescale/ ? Can they pick up all the freescale
> related dts changes and submit them as a pull request? Should they go
> through Shawn's tree maybe?

Thanks Arnd. For now, may-be I can send this patchset with Rob's Acked-by added
for 1/2 to 'arm at kernel.org'. So that this can be picked by via the arm-soc tree.
Shawn, I hope it's ok with you.

In the meanwhile, I will discuss internally as to how we can have in place a freescale maintainer,
who can submit the pull requests to the 'arm-soc' tree.

Regards,
Bhupesh

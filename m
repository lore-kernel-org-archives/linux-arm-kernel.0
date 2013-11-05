From: B47053@freescale.com (Li Xiubo)
Date: Tue, 5 Nov 2013 06:17:32 +0000
Subject: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
In-Reply-To: <20131101120700.GE10324@S2101-09.ap.freescale.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101102805.GG28401@MrMyself>
 <20131101120700.GE10324@S2101-09.ap.freescale.net>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8287564A@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > >  sound/soc/fsl/fsl-sgtl5000-vf610.c | 208
> > > +++++++++++++++++++++++++++++++++++++
> >
> > I just doubt if this file naming is appropriate. Even if we might not
> > have rigor rule for the file names, according to existing ones, they
> > are all in a same pattern: [SoC name]-[codec name].c
> >
> > "imx-sgtl5000.c" for example
> >
> > I think it would make user less confused about what this file exactly
> > is if this machine driver also follow the pattern: vf610-sgtl5000.c
> >
> >
> > @Shawn
> >
> > What do you think about the file name?
> 
> Yeah, it would be better to name the file following the existing the
> pattern.
> 

Please see the next version.

Best Regards,
Xiubo

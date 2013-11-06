From: B47053@freescale.com (Li Xiubo)
Date: Wed, 6 Nov 2013 09:38:26 +0000
Subject: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <20131106081257.GR19770@S2101-09.ap.freescale.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <5278F1FA.1060706@tabi.org>
 <1DD289F6464F0949A2FCA5AA6DC23F82876A53@039-SN2MPN1-013.039d.mgd.msft.net>
 <5279B822.9010401@tabi.org>
 <1DD289F6464F0949A2FCA5AA6DC23F82876B08@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131106081257.GR19770@S2101-09.ap.freescale.net>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82876FAE@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > >> If there are any comments that say PPC but are not PPC-specific,
> that
> > > >> >should be fixed.
> > > > Yes, find it.
> > > >
> > > > The comments is in "sound/soc/fsl/Makefile" :
> > > > +++++++++++
> > > > "# Freescale PowerPC SSI/DMA Platform Support"
> > > > -----------
> > > >
> > > > But fsl-spdif.o is also under it.
> > > > And this is also support ARM and PowerPC platforms at the same
> time ?
> > > > If so, the comments should be modified to :
> > > > +++++++++++
> > > > "# Freescale PowerPC and ARM SSI/DMA Platform Support"
> > > > -----------
> > >
> > > Yes, this should be changed.
> > >
> >
> > How about :
> > +++++++++
> > "# Freescale PowerPC and ARM SSI/DMA/SAI/SPDIF Platform Support"
> > ---------
> >  ?
> 
> Or we can just drop 'PowerPC and ARM'?
> 

Yes, this will be better.


Best Regards,
Xiubo

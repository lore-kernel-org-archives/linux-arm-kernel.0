From: B47053@freescale.com (Li Xiubo)
Date: Tue, 5 Nov 2013 03:26:16 +0000
Subject: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
In-Reply-To: <20131101101750.GB16492@curry>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101101750.GB16492@curry>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828754AB@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


=
> [...]
> > diff --git a/sound/soc/fsl/fsl-sgtl5000-vf610.c b/sound/soc/fsl/fsl-
> sgtl5000-vf610.c
> > new file mode 100644
> > index 0000000..f535b42
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> > @@ -0,0 +1,208 @@
> > +/*
> > + * Freeacale ALSA SoC Audio using SGT1500 as codec.
>           ^                             ^   ^
>      "Freescale"                    "SGTL5000"
> 
Yes. See the next version.

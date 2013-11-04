From: B47053@freescale.com (Li Xiubo)
Date: Mon, 4 Nov 2013 09:52:44 +0000
Subject: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
In-Reply-To: <20131101184008.GF2493@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101184008.GF2493@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82874583@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Conflicts:
> > 	sound/soc/fsl/Makefile
> 
> Ahem.
> 

This will be removed.

> > +static int fsl_sgtl5000_remove(struct platform_device *pdev) {
> > +	snd_soc_unregister_card(&fsl_sgt1500_card);
> > +
> > +	return 0;
> > +}
> 
> You're using snd_soc_unregister_card() so you don't need to do this.
>

See the next version.

From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 21 Oct 2013 07:50:22 +0000
Subject: [PATCHv1 6/8] ASoC: fsl: add SGT15000 based audio machine driver.
In-Reply-To: <20131018173331.GV2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-7-git-send-email-Li.Xiubo@freescale.com>
 <20131018173331.GV2443@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286684E@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	ret = snd_soc_register_card(&fsl_sgt1500_card);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "register soc sound card failed :%d\n",
> > +				ret);
> > +		return ret;
> > +	}
> 
> Use the newly added devm_snd_soc_register_card() (in -next).
>

Okey, Please see the next version.

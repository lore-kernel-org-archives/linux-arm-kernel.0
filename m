From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 10 Sep 2013 08:12:07 +0000
Subject: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20130910065146.GA30088@pengutronix.de>
References: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
 <1378454907-22728-2-git-send-email-Li.Xiubo@freescale.com>
 <20130910065146.GA30088@pengutronix.de>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8281470E@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
> 
> On Fri, Sep 06, 2013 at 04:08:24PM +0800, Xiubo Li wrote:
> > The FTM PWM device can be found on Vybrid VF610 Tower and Layerscape
> LS-1 SoCs.
> >
> > +
> > +static int fsl_pwm_probe(struct platform_device *pdev) {
> > +	int ret = 0;
> > +	struct fsl_pwm_chip *fpc;
> > +	struct resource *res;
> > +
> > +	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> 
> You don't have to output a message when kzalloc fails, but still you
> should check for the result and return an error if necessary.
> 
Okey, I will.

--
Xiubo

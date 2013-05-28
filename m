From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 May 2013 10:38:15 +0100
Subject: [PATCH 7/7] Documentation: Update binding for Nomadik and DBx5x
 based platforms
In-Reply-To: <CACRpkdYyZZSy4VgFc+Uo=5iAF++EPmHM0U2pHcLdkDZc=Xb_sQ@mail.gmail.com>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
 <1369232581-18923-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyZZSy4VgFc+Uo=5iAF++EPmHM0U2pHcLdkDZc=Xb_sQ@mail.gmail.com>
Message-ID: <20130528093815.GH22683@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  Required properties:
> > -- compatible: "stericsson,nmk-pinctrl", "stericsson,nmk-pinctrl-db8540",
> > -              "stericsson,nmk-pinctrl-stn8815"
> > +- compatible: "stericsson,db8500-pinctrl", "stericsson,db8540-pinctrl",
> > +              "stericsson,stn8815-pinctrl"
> 
> OK...
> 
> >         pinctrl at 80157000 {
> > -               compatible = "stericsson,nmk-pinctrl";
> > +               compatible = "stericsson,u8500-pinctrl";
> 
> This does not look like a supported compatible string?

Do you still think this, or did you change you mind?

If so, what makes you think it? How does it differ from:

compatible = "arm,cortex-a9-twd-timer";
compatible = "arm,rtc-pl031";
compatible = "stericsson,db8500-gpio",
compatible = "stericsson,db8500-musb",
compatible = "stericsson,db8500-dma40",
compatible = "stericsson,db8500-prcmu";
compatible = "stericsson,db8500-prcmu-timer-4";
compatible = "stericsson,db8500-thermal";
compatible = "stericsson,db8500-prcmu-regulator";



-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

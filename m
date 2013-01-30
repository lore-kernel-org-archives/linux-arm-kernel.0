From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Jan 2013 16:58:24 +0000
Subject: [PATCH] ARM: ux500: correct typo in pinctrl Device Tree node
In-Reply-To: <51094E50.4000302@wwwdotorg.org>
References: <1359563102-5934-1-git-send-email-linus.walleij@stericsson.com>
 <51094E50.4000302@wwwdotorg.org>
Message-ID: <20130130165824.GA5078@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Stephen Warren wrote:

> On 01/30/2013 09:25 AM, Linus Walleij wrote:
> > The preference is to use '-' instead of '_' in compatible strings.
> 
> > diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
> 
> >  		pinctrl {
> > -			compatible = "stericsson,nmk_pinctrl";
> > +			compatible = "stericsson,nmk-pinctrl";
> 
> Is there a driver-side patch which this depends on too?

This seems very strange.

I'm going to reply to this email again with how the patch should look. 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

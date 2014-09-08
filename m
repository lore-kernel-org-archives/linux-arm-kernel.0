From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 8 Sep 2014 11:31:37 +0100
Subject: [PATCH v3 1/4] phy: phy-stih41x-usb: Add usb phy support for
 STiH41x SoCs.
In-Reply-To: <540D793E.9050301@ti.com>
References: <1410168638-11072-1-git-send-email-peter.griffin@linaro.org>
 <1410168638-11072-2-git-send-email-peter.griffin@linaro.org>
 <540D793E.9050301@ti.com>
Message-ID: <20140908103137.GA17057@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

> > +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> > +	if (IS_ERR(phy_provider))
> > +		return PTR_ERR(phy_provider);
> 
> registering phy provider multiple times..

Doh. Sorry for the noise, will send a v4 shortly.

regards,

Peter.

From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 7 Aug 2014 15:16:31 +0100
Subject: [PATCH v3 1/6] usb: host: usb-st-common: Add common code
 required by ohci-st and ehci-st
In-Reply-To: <20140807141457.GB12137@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
 <1407344589-24863-2-git-send-email-peter.griffin@linaro.org>
 <201408062259.10697.arnd@arndb.de>
 <20140807141457.GB12137@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140807141631.GC12137@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> > > (priv->rst);
> > > +		if (ret)
> > > +			goto err_assert_power;
> > > +	}
> > 
> > I wouldn't make these optional, just call the functions
> > unconditionally and fail the probe function if they are
> > not available.

Also I've also done as you suggest and made
these non optional in V4.

regards,

Peter.

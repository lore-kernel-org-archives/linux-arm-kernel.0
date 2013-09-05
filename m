From: marex@denx.de (Marek Vasut)
Date: Thu, 5 Sep 2013 12:51:39 +0200
Subject: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
In-Reply-To: <20130905104256.GK6329@mwanda>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <201309051216.18305.jbe@pengutronix.de> <20130905104256.GK6329@mwanda>
Message-ID: <201309051251.39877.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dan Carpenter,

> On Thu, Sep 05, 2013 at 12:16:18PM +0200, J?rgen Beisert wrote:
> > I like this simplification, but all the other drivers for the MXS series
> > of SoCs don't use such a method. Do you think this "new style" will be
> > accepted?
> 
> My lradc_plate_mask() is basically the same idea as what Marek said
> about putting the logic into the define.
> 
> LRADC....IRQ_MASK(id) (((id) == MX23) ? 0x1ff : 0x1fff)
> 
> I don't know why Marek is complaining about churn though.  This is
> linux!  We love churn!  And especially in staging, it's our favorite
> thing.  :P

About time to move this driver out of staging then ;-)

Best regards,
Marek Vasut

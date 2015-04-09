From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Thu, 9 Apr 2015 14:59:27 +0200
Subject: [PATCHv7] media: i2c/adp1653: fix includes
In-Reply-To: <CABxcv=mB=LqO2paGfYq1jCbky=kudT-mS8cJ-pPwdqZYQLeO4A@mail.gmail.com>
References: <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd> <20150409091017.GA4526@earth>
 <20150409112943.GA31173@amd> <20150409121913.GB18713@earth>
 <20150409123155.GB9563@amd>
 <CABxcv=mB=LqO2paGfYq1jCbky=kudT-mS8cJ-pPwdqZYQLeO4A@mail.gmail.com>
Message-ID: <20150409125927.GC12339@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 April 2015 14:43:59 Javier Martinez Canillas wrote:
> Hello Pavel,
> 
> >
> > diff --git a/drivers/media/i2c/adp1653.c b/drivers/media/i2c/adp1653.c
> > index d703636..7107ac2 100644
> > --- a/drivers/media/i2c/adp1653.c
> > +++ b/drivers/media/i2c/adp1653.c
> > @@ -35,8 +35,8 @@
> >  #include <linux/module.h>
> >  #include <linux/i2c.h>
> >  #include <linux/slab.h>
> > -#include <linux/of_gpio.h>
> > -#include <linux/gpio.h>
> > +#include <linux/of.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <media/adp1653.h>
> >  #include <media/v4l2-device.h>
> >
> 
> Please re-spin your previous patch and submit it properly.
> 
> Best regards,
> Javier

Hi all! What about stopping this meaningless discussion about resending
full patch series when everybody know how to fix is quickly in editor
(e.g with sed under 5s) and not wasting another 10 minutes to generate
new unified diff sent via SMTP protocol?

-- 
Pali Roh?r
pali.rohar at gmail.com

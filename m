From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Dec 2016 20:42:07 +0100
Subject: [PATCH v6 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <20161213092031.d2ax2pnpzzicriel@pengutronix.de>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-3-git-send-email-cedric.madianga@gmail.com>
 <20161213092031.d2ax2pnpzzicriel@pengutronix.de>
Message-ID: <20161215194207.GB1741@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +	if (ret) {
> > +		dev_err(i2c_dev->dev, "bus not free\n");
> > +		ret = -EBUSY;
> 
> I'm not sure if "bus not free" deserves an error message. Wolfram?

I tend to agree. But I never enforced it up to now, never found the time
to double check if I could/should enforce it.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161215/45e9de14/attachment.sig>

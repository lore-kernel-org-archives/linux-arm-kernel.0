From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 2 Sep 2017 23:58:30 +0200
Subject: [I2C] About warning 'DMA-API: device driver maps memory from
 stack'
In-Reply-To: <1504354088.31793.48.camel@mhfsdcap03>
References: <1504354088.31793.48.camel@mhfsdcap03>
Message-ID: <20170902215829.3jpwmbyy27cpu5rm@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

nice to see someone else interested in the I2C & DMA topic.

Please check this series which I sent out recently:

"[RFC PATCH v4 0/6] i2c: document DMA handling and add helpers for it"

In that series, I proposed...

> 3. kmalloc data buffer instead of local variables buf in function
> i2c_smbus_xfer_emulated(...)

... this solution. Although I have to check Mauro's general response to
the series first. I'd be interested in what you think of the series,
too.

Kind regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170902/e27fa1a7/attachment.sig>

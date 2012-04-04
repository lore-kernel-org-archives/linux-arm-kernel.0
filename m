From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 4 Apr 2012 09:57:48 +0200
Subject: [PATCH] mtd/gpmi : do not include the mxs.h
In-Reply-To: <CAMiH66FhFFi1Kd7t6uK4S46Yt=g1kxxCUZywCNAmy14E1AHH1A@mail.gmail.com>
References: <1333247817-18472-1-git-send-email-shijie8@gmail.com>
 <20120403193920.GC2201@pengutronix.de>
 <CAMiH66FhFFi1Kd7t6uK4S46Yt=g1kxxCUZywCNAmy14E1AHH1A@mail.gmail.com>
Message-ID: <20120404075748.GA9073@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Do you mean your patch "lib: add support for stmp-style devices" ?
> or some other patch?

Yes, it adds the SET and CLR macros. writel() then need to be modified again.
Nothing major, though.

> Your patch "lib: add support for stmp-style devices" does not give me the API
> to remove this code as i ever wished to.

Then please speak up. The only comment I can find from you is the requested
move to a fsl-directory, but this is nothing about API?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120404/d3f8f34d/attachment.sig>

From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 06 Jul 2013 12:51:58 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDI3IHBoeUNBUkQtUyByZW1vdmUg?=
 =?UTF-8?B?d3JvbmcgSTJDIFJUQw==?=
In-Reply-To: <1373031909-16178-1-git-send-email-mpa@pengutronix.de>
References: <1372782469.486055292@f129.mail.ru>
 <1373031909-16178-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1373100718.107651915@f159.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Fixup of commit 7874d595b78e431f0f661d2fe47625649308a52e
> "ARM: dts: Add device tree support for phycard pca100".
> 
> Remove wrong I2C RTC node.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> 
> Thanks, Alexander, you are right. I2C2 has no RTC.
...

There are a couple of comments on this file.

I think that the OWIRE should be moved to the RDK.

ioexpander must contain "gpio-controller" at least, and for use it further,
it is necessary to define the label for this node.

Thanks.

---

From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 29 May 2013 12:49:13 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gU1BJOiBVbmlmeSBzaW1wbGUgcGxhdGZvcm0gZGF0YSBm?=
 =?UTF-8?B?b3Igc29tZSBjb250cm9sbGVycw==?=
In-Reply-To: <1743419.NY2Q01i8Iq@wuerfel>
References: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
 <1743419.NY2Q01i8Iq@wuerfel>
Message-ID: <1369817353.993218858@f175.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wednesday 29 May 2013 10:42:22 Alexander Shiyan wrote:
> > This patch unifies simple pdata for some SPI controllers where only
> > array of GPIOs is used for define chipselects.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Wouldn't it be better to kill off the platform_data for these drivers
> and pass the gpio number through spi->controller_data as the
> spi_gpio driver does?

Interesting way. Just one question remains, for using not-dt variant,
how  we should specify num_chipselect parameter for master?
I see only way for specify maximum constant in the driver.

---

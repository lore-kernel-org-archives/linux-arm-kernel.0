From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 17 Nov 2014 11:38:54 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gZ3BpbzogbXhzOiBpbXBsZW1lbnQgZ2V0X2RpcmVjdGlv?=
 =?UTF-8?B?biBjYWxsYmFjaw==?=
In-Reply-To: <20141117082848.GZ27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
Message-ID: <1416213534.761947189@f70.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

...
> > struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int
> > idx, int *irqs)
> What is idx about? I see it already in the mctrl_gpio API, but there is
> no documentation about how it's used. Is it always 0?

This could be used for drivers with several UARTs, which registered at once.

---

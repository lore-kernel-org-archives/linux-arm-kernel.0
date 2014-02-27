From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 27 Feb 2014 18:07:55 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzNdIEFSTS9sZWRzOiBtb3ZlIEFSTSBWZXJzYXRpbGUg?=
 =?UTF-8?B?TEVEIGRyaXZlciB0byBsZWRzIHN1YnN5c3RlbQ==?=
In-Reply-To: <1393509500-26002-2-git-send-email-linus.walleij@linaro.org>
References: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
 <1393509500-26002-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <1393510075.460580224@f137.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 27 ??????? 2014, 14:58 +01:00 ?? Linus Walleij <linus.walleij@linaro.org>:
> Now that we have converted this driver to a real platform device
> module-based thing, we move the driver down into the LEDs
> subsystem and rename the config option to LEDS_VERSATILE.

In fact, it can be converted to use basic-mmio-gpio => leds-gpio.

---

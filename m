From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2011 10:12:51 +0200
Subject: [PATCH 2/4] gpio: move Nomadik GPIO driver to drivers/gpio
In-Reply-To: <20110524230546.GC4652@n2100.arm.linux.org.uk>
References: <1306271221-28978-1-git-send-email-linus.walleij@stericsson.com>
	<20110524230546.GC4652@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinvBoce7UACjuUF3NnrVXk0_wyzFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/25 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Tue, May 24, 2011 at 11:07:01PM +0200, Linus Walleij wrote:
>> -config NOMADIK_GPIO
>> - ? ? bool
>> - ? ? help
>> - ? ? ? Support for the Nomadik GPIO controller.
>> -
>
> What about the statements which select this config symbol?

Ayes, thanks a lot Russell, I've sent a separate patch deleting these.

Yours,
Linus Walleij

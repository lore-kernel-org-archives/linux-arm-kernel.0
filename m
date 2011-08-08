From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 Aug 2011 11:32:52 +0200
Subject: [RFC PATCH 2/2] GPIO: add gpiolib and irqchip for CSR SiRFprimaII
	GPIO controller
In-Reply-To: <20110726100928.GO9653@n2100.arm.linux.org.uk>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2ModXNQXCLZW09+RsRraOdO4UaoGQeqx3MRrw+U5vBQnzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/26 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> [Barry]
>> +#include <asm-generic/gpio.h>
>> +
>> +#define gpio_get_value ? ? ? __gpio_get_value
>> +#define gpio_set_value ? ? ? __gpio_set_value
>> +#define gpio_cansleep ? ? ? ?__gpio_cansleep
>
> Hmm, yet another trivial gpio implementation. ?We have 24 others just like
> this. ?Well, mainline does... I have just one. ?Patches after the merge
> window closes.

Hm, that sounds very good, now the merge window is closed, can you
post them? Me and Ben have some stash of GPIO patches as well so
we may just as well base them atop of your cleanup.

Thanks,
Linus Walleij

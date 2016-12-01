From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 1 Dec 2016 13:48:08 +0000
Subject: [PATCH 1/5] gpio: pl061: use local state for parent IRQ storage
In-Reply-To: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
References: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <be5a081a-24d7-ff50-d8c5-01e02e64a5dc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/11/16 10:09, Linus Walleij wrote:
> The driver is poking around in the struct gpio_chip internals,
> which is a no-no. Use a variable in the local state container.
>

The entire series looks good to me. I also gave it a spin on my Juno. So,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

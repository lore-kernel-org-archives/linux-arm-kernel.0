From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Oct 2012 21:56:43 +0200
Subject: [PATCH RFC 1/6 v3] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <1350069085-13283-2-git-send-email-stigge@antcom.de>
References: <1350069085-13283-1-git-send-email-stigge@antcom.de>
 <1350069085-13283-2-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdZ54+Vm36fm=V4p1MhPuU=-=5mk9j7QsCpZYpc1WnY=dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 9:11 PM, Roland Stigge <stigge@antcom.de> wrote:

> +#define NR_GPIO_BLOCKS 16
> +
> +static struct gpio_block *gpio_block[NR_GPIO_BLOCKS];

16 looks quite arbitrary, as noted elsewhere please use a list.

Yours,
Linus Walleij

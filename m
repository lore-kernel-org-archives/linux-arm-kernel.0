From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Mar 2018 22:04:56 +0100
Subject: [PATCH 2/2] ARM: pinctrl: stm32: Optimizes and enhances stm32gpio
 irqchip
In-Reply-To: <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
Message-ID: <CACRpkdbmmx7y3xJOOy0Dx62tMonkCgZeVzKYzr1B362QZe0fsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 2:50 PM, Radoslaw Pietrzyk
<radoslaw.pietrzyk@gmail.com> wrote:

>         - removes unneeded irq_chip.irq_eoi callback
>         - adds irq_chip.irq_set_wake callback for possible
>         in the future GPIO wakeup
>
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>

Patch applied with Alexandre's ACK, stripping ARM from the
commit message, thanks!

Yours,
Linus Walleij

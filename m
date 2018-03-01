From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Mar 2018 23:41:54 +0100
Subject: [PATCH v2 2/2] pinctrl: stm32: Optimizes and enhances stm32gpio
 irqchip
In-Reply-To: <c648235f538b030e7f349e286661fd00894d5316.1519374248.git.radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <c648235f538b030e7f349e286661fd00894d5316.1519374248.git.radoslaw.pietrzyk@gmail.com>
Message-ID: <CACRpkdYfbgdr9QsTudYdr8EnXgMzwqm_iP2m1ya3hQkyTBjgqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 9:31 AM, Radoslaw Pietrzyk
<radoslaw.pietrzyk@gmail.com> wrote:

> - removes unneeded irq_chip.irq_eoi callback
> - adds irq_chip.irq_set_wake callback for possible
> in the future GPIO wakeup
> - adds irq_chip.irq_ack callback
>
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>

This v2 patch applied with Ludovic's tags.

Yours,
Linus Walleij

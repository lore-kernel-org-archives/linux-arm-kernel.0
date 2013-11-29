From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 08:43:00 +0100
Subject: [PATCH v6 3/6] gpio: davinci: remove unused variable intc_irq_num
In-Reply-To: <1385057731-4348-4-git-send-email-prabhakar.csengg@gmail.com>
References: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>
 <1385057731-4348-4-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <CACRpkdZaSgEMTPPSYJyENc+zhTTLhzchi2F=CzdZs=DskMvVwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 7:15 PM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:

> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>
> As the davinci-gpio driver is migrated to use irqdomain
> there is no need to pass the irq base for the gpio driver.
> This patch removes this variable from davinci_gpio_platform_data
> and also the refrences from the machine file.
>
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

*Very* nice patch!

Yours,
Linus Walleij

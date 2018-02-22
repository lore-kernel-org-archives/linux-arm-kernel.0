From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 13:51:32 +0100
Subject: [PATCH v5 4/5] ARM: dts: bcm2835: make the firmware node into a
 bus
In-Reply-To: <43f9082a6835df6d7bcd3e16d79db687c52826d2.1519128054.git.baruch@tkos.co.il>
References: <cover.1519128054.git.baruch@tkos.co.il>
 <43f9082a6835df6d7bcd3e16d79db687c52826d2.1519128054.git.baruch@tkos.co.il>
Message-ID: <CACRpkdZj0Q8iu5rmqW2ZkrwhzPD0xuHV63P9zEyhSLFUrh5QiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 1:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:

> This allows adding devices for which the firmware exposes control interface
> via the mailbox. An example of such device is the GPIO expander.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v4: New patch in this series

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this patch through the ARM SoC tree.

Yours,
Linus Walleij

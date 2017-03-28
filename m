From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Mar 2017 11:17:40 +0200
Subject: [PATCH v4 2/4] pinctrl: rockchip: convert to raw spinlock
In-Reply-To: <20170323105931.10455-3-john@metanate.com>
References: <20170323105931.10455-1-john@metanate.com>
 <20170323105931.10455-3-john@metanate.com>
Message-ID: <CACRpkdZpKoBF1b8OwVWfFm9cMX06TjAv9m4Ra5Xp0vy4GzJJGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 11:59 AM, John Keeping <john@metanate.com> wrote:

> This lock is used from rockchip_irq_set_type() which is part of the
> irq_chip implementation and thus must use raw_spinlock_t as documented
> in Documentation/gpio/driver.txt.
>
> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v3: unchanged
> v2: unchanged

Patch applied.

Yours,
Linus Walleij

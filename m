From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Sep 2016 14:44:35 +0200
Subject: [PATCH 0/7] mfd: Fix all W=1 warnings
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Message-ID: <CACRpkdYGW4bkWXZp6JWMLCxne0a7cp9rNkipA_tZmzL=9CRjfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 12:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It really is as simple as it sounds!
>
> Lee Jones (7):
>   mfd: max8997-irq: 'inline' should be at the beginning of the
>     declaration
>   mfd: ab8500-debugfs: Prevent initialised field from being over-written
>   mfd: db8500-prcmu: Remove unused *prcmu_set_ddr_opp() calls
>   mfd: ab8500-debugfs: Remove ab8500_dump_all_banks_to_mem()
>   mfd: ab8500-debugfs: Remove 'weak' function
>     suspend_test_wake_cause_interrupt_is_mine()
>   mfd: omap-usb-host: Return value is not 'const int'
>   mfd: cros_ec_spi: Remove unused variable 'request'

Acked-by: Linus Walleij <linus.walleij@linaro.org>

For all the ab8500 and db8500 stuff.

Yours,
Linus Walleij

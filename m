From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Sep 2017 13:43:38 +0200
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
 <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
Message-ID: <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 2:32 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 9/19/17 3:15 AM, Linus Walleij wrote:
>>
>> Oh we already have that I think, Mika Westerberg and Andy Shevcheno
>> implemented that for anyone using CONFIG_GPIOLIB_IRQCHIP, and
>> this driver does. Timur please check: irq_need_valid_mask, irq_valid_mask
>> usage.
>
> These patches already use irq_valid_mask!  But that doesn't block complete
> access to the GPIO.

Aha sorry for my ignorance :(

Doesn't that mean we need something like irq_valid_mask but rather
gpio_valid_mask that just block all usage of certain GPIOs?

Yours,
Linus Walleij

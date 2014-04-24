From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 24 Apr 2014 15:25:16 -0700
Subject: [PATCH v3] gpio: omap: implement get_direction
In-Reply-To: <CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
 (Linus Walleij's message of "Thu, 24 Apr 2014 15:13:04 +0200")
References: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
 <CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
Message-ID: <7hppk6nz5f.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Thu, Apr 24, 2014 at 8:57 AM,  <yegorslists@googlemail.com> wrote:
>
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> This patch implements gpio_chip's get_direction() routine, that
>> lets other drivers get particular GPIOs direction using
>> struct gpio_desc.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>> Changes:
>>         v3: get rid of _get_gpio_direction() (Linus Walleij)
>>         v2: rework return value calculation
>
> Looks good to me, Kevin, Santosh?

Reviewed-by: Kevin Hilman <khilman@linaro.org>

> Part of me wants to list Javier as maintainer for this driver.

That's fine with me. 

Kevin

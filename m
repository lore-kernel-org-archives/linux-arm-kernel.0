From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Dec 2017 13:19:39 +0100
Subject: [PATCH v1] mfd: ab8500: introduce DEFINE_SHOW_ATTRIBUTE() macro
In-Reply-To: <20171215105432.pm36mtles7mpvcye@dell>
References: <20171214105121.77015-1-andriy.shevchenko@linux.intel.com>
 <20171215105432.pm36mtles7mpvcye@dell>
Message-ID: <CACRpkdYY=rk=fGg67CYoTnokQL_dTnQLgkbmhKLy07-3vHkNPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 11:54 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Linus,
>
>> This macro deduplicates a lot of similar code in the ab8500-debugfs.c module.
>> Targeting to be moved to seq_file.h eventually.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Excellent cleanup.

Can't test it right now, if it causes any runtime fallout I will handle it.

Yours,
Linus Walleij

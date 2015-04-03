From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 4 Apr 2015 01:14:04 +0300
Subject: [PATCH v5 08/15] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <CAHp75VfPn_+sg_1iR_CdR2KuTyWcR+SKFsuHCbCkCKB0Oeqgfg@mail.gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428080481-18591-9-git-send-email-mcoquelin.stm32@gmail.com>
 <CAHp75VfPn_+sg_1iR_CdR2KuTyWcR+SKFsuHCbCkCKB0Oeqgfg@mail.gmail.com>
Message-ID: <CAHp75Ve+2UUyPAM6ZnYLXaLNOaEA4DGnY6y=VCQxZpdo+cYBfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 4, 2015 at 1:09 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Apr 3, 2015 at 8:01 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> STM32 MCUs feature 16 and 32 bits general purpose timers with prescalers.
>> The drivers detects whether the time is 16 or 32 bits, and applies a
>> 1024 prescaler value if it is 16 bits.

[]

>> +               pr_err("failed to get clock for clockevent (%d)\n", ret);
>
> Why not dev_err(); ?

Understood, because it's device tree with lack of something like of_err();

-- 
With Best Regards,
Andy Shevchenko

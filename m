From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Sep 2014 15:39:13 -0700
Subject: [PATCH 1/7 v6] leds: add a driver for syscon-based LEDs
In-Reply-To: <CACRpkdaZhzaA4RxO7fsUSzxquqF4M0g3WXHXPeG5YyF9HttdHg@mail.gmail.com>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
 <1410176286-32533-2-git-send-email-linus.walleij@linaro.org>
 <CACRpkdaZhzaA4RxO7fsUSzxquqF4M0g3WXHXPeG5YyF9HttdHg@mail.gmail.com>
Message-ID: <CACRpkdZkYx73VPJpdxyyjuo4uQ=+zJ5ALYh86B7DGZe_vdUiOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 1:56 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 8, 2014 at 1:38 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> This makes it possible to create a set of LEDs from a syscon
>> MFD instance, which is lean mean and clean on the ARM
>> reference designs and can replace the Versatile LEDs driver
>> in the long run, as well as other custom syscon LEDs drivers.
>>
>> Cc: Bryan Wu <cooloney@gmail.com>
>> Cc: Richard Purdie <rpurdie@rpsys.net>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v1->v2:
>> - Augment driver to probe all nodes of a syscon to see if they
>>   are "register-bit-led"s, and then allocate them under the syscon
>>   if that is the case.
>> - Switch compatible string from "syscon-leds" to "register-bit-led"
>
> Bryan can you please ACK this patch if you're OK with it so
> it can be pulled in through ARM SoC?

Ping!

I will send a pull request for this soon anyway.

Yours,
Linus Walleij

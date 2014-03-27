From: cooloney@gmail.com (Bryan Wu)
Date: Thu, 27 Mar 2014 10:30:57 -0700
Subject: [PATCH 2/3] ARM/leds: move ARM Versatile LED driver to leds
 subsystem
In-Reply-To: <CACRpkdZo0jpr9sCkYDbtYiK8rFrgqt36OhyMR-iLjEmAtLGnAA@mail.gmail.com>
References: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
 <1393509500-26002-2-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZo0jpr9sCkYDbtYiK8rFrgqt36OhyMR-iLjEmAtLGnAA@mail.gmail.com>
Message-ID: <CAK5ve-KscsG7H=x2m7Aid-=PtSjqYEt6eQVfRTRGJZya_=zDZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 5:19 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Feb 27, 2014 at 2:58 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> Now that we have converted this driver to a real platform device
>> module-based thing, we move the driver down into the LEDs
>> subsystem and rename the config option to LEDS_VERSATILE.
>>
>> Cc: Bryan Wu <cooloney@gmail.com>
>> Cc: Richard Purdie <rpurdie@rpsys.net>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Bryan: can you provide an ACK for this patch so I can funnel
>> this through the ARM SoC tree?
>
> Ping on this.
>

Apologize for this delay, this patch email didn't show up in my inbox.
Please go ahead with my ack

Acked-by: Bryan Wu <cooloney@gmail.com>

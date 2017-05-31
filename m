From: yegorslists@googlemail.com (Yegor Yefremov)
Date: Wed, 31 May 2017 19:22:22 +0200
Subject: [PATCH RFC 2/5] ARM: dts: am335x-baltos: use IRQ_TYPE_* to
 specify irq flags
In-Reply-To: <20170531171932.GH3730@atomide.com>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
 <20170526180609.2699-2-uwe@kleine-koenig.org>
 <20170531171932.GH3730@atomide.com>
Message-ID: <CAGm1_ktJp+3t9ExuFJhKTmbM63yt-82PGP26KkEHGqK-tnfWRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe, Tony,

On Wed, May 31, 2017 at 7:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Uwe Kleine-K?nig <uwe@kleine-koenig.org> [170526 11:09]:
>> According to the binding documentation and the source code the omap-gpio
>> controller takes IRQ_TYPE_* as its flags values, not GPIO_ACTIVE_*.
>>
>> This patch uses the right variable type which yields the same result
>> when compiled. Note that this might be wrong and actually
>> IRQ_TYPE_LEVEL_LOW is intended by the dt author.
>>
>> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
>> ---
>> Hello,
>>
>> can somebody with the hardware or it's documentation please check which
>> flag is the right one?
>
> I'll wait on this one until we have somebody test it.

I'll look at it this week.

Yegor

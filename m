From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Oct 2017 21:32:09 +0200
Subject: [PATCH v6 2/5] clocksource: stm32: convert driver to timer_of
In-Reply-To: <alpine.DEB.2.20.1710182028080.2477@nanos>
References: <1508331506-23782-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508331506-23782-3-git-send-email-benjamin.gaignard@linaro.org>
 <alpine.DEB.2.20.1710182028080.2477@nanos>
Message-ID: <CA+M3ks4Eg2-S8yDZuMd-jqZ6g2efvveU_WwQEh0rPZW0fGDt3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-18 20:31 GMT+02:00 Thomas Gleixner <tglx@linutronix.de>:
> On Wed, 18 Oct 2017, Benjamin Gaignard wrote:
>
>> Convert driver to use timer_of helpers. This allow to remove
>> custom proprietary structure.
>>
>> Increase min delta value because if it is too small it could
>> generate too much interrupts and the system will not be able
>> to catch them all.
>
> This does two completely independent changes at once. What the heck has
> increasing min delta to do with converting it to timer_of() helpers?
>
> Nothing at all. So please split this into two distinct patches. Each doing
> ONE thing.

I will do that.

>
> See Documentation/process/submitting-patches.rst:
>
>   3) Separate your changes
>   ------------------------
>
>   Separate each **logical change** into a separate patch.
>
> Reading, understanding and complying with that document is not optional.
>
> Thanks,
>
>         tglx



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog

From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 14 Jan 2017 00:51:09 +0100
Subject: [PATCH 4/4] ARM64: dts: meson: meson-gx: add the SAR ADC
In-Reply-To: <85c07462-c175-faf8-8dae-403a6291331e@gmail.com>
References: <2c7996a6-9c55-4cee-75a1-01be8732c42a@gmail.com>
 <CAFBinCC_AYS0ogzdpGVRoeS2ETjcD6fdmzq3kmX_u=9heBu6oA@mail.gmail.com>
 <85c07462-c175-faf8-8dae-403a6291331e@gmail.com>
Message-ID: <CAFBinCBwbcYRVfhyPN=2ZcNhteLu9Eu43MxhTFgS3dsmrtqEVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 9:14 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Am 13.01.2017 um 20:50 schrieb Martin Blumenstingl:
>> Hi Heiner,
>>
>> On Fri, Jan 13, 2017 at 8:32 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>> Sorry, I'm not subscribed to the two mailing lists, therefore my reply
>>> is outside the thread.
>>>
>>> I'm currently experimenting with an own rudimentary driver for SAR ADC
>>> on a Odroid C2 (S905GXBB). So I have some remarks based on my experience.
>> I hope that we haven't been duplicating too much work!
>>
> No, my driver doesn't include all the clock handling and relies on the
> boot loader / firmware to do this. Also I don't support averaging mode.
> Your driver is much more comprehensive and I would go with it.
>
> I have some features like interrupt mode and calibration which are not
> yet supported in your driver but they can be easily migrated and added
> later.
indeed, that'll leave some fun for you as well :-)

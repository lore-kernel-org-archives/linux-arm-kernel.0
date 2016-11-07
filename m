From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 7 Nov 2016 22:50:58 +0530
Subject: [PATCH 3/6] clk: Add driver for Maxim-8997 PMIC clocks
In-Reply-To: <63750c2f-35cb-91ab-276b-c788f51081cb@osg.samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
 <1478513376-14307-4-git-send-email-pankaj.dubey@samsung.com>
 <63750c2f-35cb-91ab-276b-c788f51081cb@osg.samsung.com>
Message-ID: <CAGcde9EkEsvJ2kBpNvd+bEZj0nbpgmFu1zBe+RQz+Kij9WxHMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 7 November 2016 at 20:31, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Pankaj,
>
> On 11/07/2016 07:09 AM, Pankaj Dubey wrote:
>> The MAX8997 PMIC has 32.786kHz crystal oscillator which provides an
>> accurate low frequency clock for MAX8997 internal circuit as well as
>> external circuit. This patch adds support for these two clocks.
>>
>> CC: Michael Turquette <mturquette@baylibre.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: devicetree at vger.kernel.org
>> CC: linux-clk at vger.kernel.org
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>
> What kernel version are you basing this on? The Maxim common clock code

This patch series, I have prepared on Krzysztof's for-next which is 4.9-rc1,

> is going away for v4.9 and instead the clk-max77686 driver supports both
> 77686 and 77802 clocks. See commit 8ad313fe4e00 ("clk: max77686: Combine
> Maxim max77686 and max77802 driver").
>
> Since the 8997 clock IP looks very similar to 77802 AFAICT, you should
> also extend the clk-max77686 driver to have 8997 support.
>

I was not aware of this change. I will check this and if I can
reuse/extend max77686 for 8997 I will do it.

Thanks,
Pankaj Dubey

> Best regards,
> --
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

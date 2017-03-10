From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Mar 2017 11:15:35 +0100
Subject: [PATCH v6 00/14] mmc: Add support to Marvell Xenon SD Host
 Controller
In-Reply-To: <CAPDyKFqXQmuxWFZwcnTgQcKU_t5MKCtBj6s+tv5gzVWS11x0qA@mail.gmail.com>
 (Ulf Hansson's message of "Mon, 20 Feb 2017 20:32:58 +0100")
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <87y3x0ajdv.fsf@free-electrons.com>
 <CAPDyKFqXQmuxWFZwcnTgQcKU_t5MKCtBj6s+tv5gzVWS11x0qA@mail.gmail.com>
Message-ID: <87innhjv3s.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,
 
 On lun., f?vr. 20 2017, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 20 February 2017 at 17:59, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> Hi Ulf,
>>
>>  On mar., f?vr. 14 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>>
>>> Hello,
>>>
>>> This the sixth version of the series adding support for the SDHCI
>>> Xenon controller. It can be currently found on the Armada 37xx and the
>>> Armada 7K/8K but will be also used in more Marvell SoC (and not only
>>> the mvebu ones actually).
>>>
>>> Most of the following changes had been discussed on the mailing list,
>>> except the new compatible string.
>>>
>>
>> I think that with this version we addressed all the concerns expressed
>> about the previous version. Do you think that you will be able to apply
>> this series for 4.11 or do you still see any issues?
>>
>> Thanks,
>>
>> Gregory
>
> We are in the merge window for v4.11, so new material is out of the
> question. I am preparing the PR to Linus as this very moment.

v4.11-rc1 was released last week, do you want that I rebase the series
ontop of it ?

On our side we made several tests of this version of the driver on
various hardware and everything works as expected. We only notice some
configuration to update for the dts on some board but it didn't impact
the driver itself.

Gregory


>
> Anyway, I will look into the series as soon as I can.
>
> Kind regards
> Uffe
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

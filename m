From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 2 Jun 2016 08:19:24 -0600
Subject: [PATCH] coresight: Handle build path error
In-Reply-To: <574F23B7.2020409@arm.com>
References: <CANLsYkwEG-4U+hvdVNHQxoH_WuZvD_pYwDC6NSBOok9o5swNoA@mail.gmail.com>
 <1462545350-15970-1-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkwtSTwRD9kjqU0v60wNHoRLoXW1hTwRq3tZemO=RqnhQw@mail.gmail.com>
 <574F23B7.2020409@arm.com>
Message-ID: <CANLsYkyFSaVnkBnfYrxjv1K0mK7X=pVwASr-7ttX6h6y0exNNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2016 at 12:04, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 06/05/16 15:43, Mathieu Poirier wrote:
>>
>> On 6 May 2016 at 08:35, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>
>>> Enabling a component via sysfs (echo 1 > enable_source), would
>>> trigger building a path from the enabled sources to the sink.
>>> If there is an error in the process (e.g, sink not enabled or
>>> the device (CPU corresponding to ETM) is not online), we never report
>>> failure, except for leaving a message in the dmesg.
>>>
>
>>>
>>
>> Thanks for the correction:
>>
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>> Greg, given how small the changes are can you pick this up?  Otherwise
>> I'll simply keep it in my tree.
>
>
> Should this go in for rc2 as a fix ?

It did not make it in time for the 4.7 merge window - it will be part
of the 4.8 cycle.

Thanks,
Mathieu

>
> Cheers
> Suzuki
>

From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 2 Mar 2018 14:15:05 +0530
Subject: [PATCH v2 00/11] perf events patches for improved ARM64 support
In-Reply-To: <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava>
 <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
Message-ID: <CAKTKpr4vDByhQ_16XT_+Uo4An3KF_UOB7CTYBrG7Miu0ujDaXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Fri, Mar 2, 2018 at 1:54 PM, John Garry <john.garry@huawei.com> wrote:
> On 27/02/2018 09:50, Jiri Olsa wrote:
>>
>> On Sat, Feb 24, 2018 at 12:05:21AM +0800, John Garry wrote:
>>>
>>> This patchset adds support for some perf events features,
>>> targeted at ARM64, implemented in a generic fashion.
>>>
>>> The two main features are as follows:
>>> - support for arch/vendor/platform pmu events directory structure
>>>    - to support this, topic subdirectory support needs to be dropped
>>> - support for parsing standard architecture pmu events
>>>
>>> On the back of these, the Cavium ThunderX2, ARM Cortex-A53,
>>> and HiSilicon hip08 JSONs are relocated/added/updated.
>>>
>>> In addition, there is a patch to drop mutli-mapfile.csv support and
>>> also a bugfix in jevents.c for an error code value.
>>>
>>> Differences to v1:
>>> - Address coding issues from Jiri Olsa in adding arch std event
>>>    support (https://lkml.org/lkml/2018/2/6/501)
>>> - add patch to drop topic subdirectory support
>>> - add patch for bug fix in json_events()
>>> - add review tags from Jiri Olsa
>>
>>
>> can't tell if those json file changes are ok, but for all the code
>> changes:
>>
>
> Hi William, Ganapatrao,
>
> Can you check the modifications to the ARM64 JSONs you originally submitted
> in the patchset please?

Sorry,  i have missed to notice. I will go through this series and
share my feedback in couple of days.

>
> If they are not checked, I'll have to see if the maintainers will accept
> without your review. If not, I'll have to drop them.
>
> Thanks,
> John
>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>
>> thanks,
>> jirka
>>
>> .

thanks
Ganapat
>>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

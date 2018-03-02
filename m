From: john.garry@huawei.com (John Garry)
Date: Fri, 2 Mar 2018 16:40:09 +0000
Subject: [PATCH v2 00/11] perf events patches for improved ARM64 support
In-Reply-To: <CAKTKpr5FfPWhQsTFjih+dfGXdKqL9-+PMoAPs_d9j5hje7OjVg@mail.gmail.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava>
 <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
 <cafdb160-3072-389b-8c31-93f09eff84a8@redhat.com>
 <CAKTKpr5FfPWhQsTFjih+dfGXdKqL9-+PMoAPs_d9j5hje7OjVg@mail.gmail.com>
Message-ID: <4d22ba78-dba7-a550-f31b-64f29e3f0cbc@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> Can you check the modifications to the ARM64 JSONs you originally submitted in the patchset please?>
>>> If they are not checked, I'll have to see if the maintainers will accept without your review. If not, I'll have to drop them.
>
> I am seeing issue(log below) with this patchset on our platfrom.
> i have tried using your v2 branch [1]
>
> root at borg-1>perf_acme>> ./perf --version
> perf version 4.16.rc1.g087f7ca
> root at borg-1>perf_acme>> ./perf stat -e bus_access_rd sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>             23,099      bus_access_rd
>
>        1.000708516 seconds time elapsed
>
> root at borg-1>perf_acme>> cd -
> /ganapat/perf/linux-hisi/tools/perf
> root at borg-1>perf>> ./perf --version
> perf version 4.16.rc1.gcb5a74
> root at borg-1>perf>> ./perf stat -e bus_access_rd sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>                  0      bus_access_rd
>
>        1.000709162 seconds time elapsed
>
> root at borg-1>perf>>
>
>
> [1] https://github.com/hisilicon/linux-hisi.git

Hi Ganapatrao,

Thanks for the notification. Let me check this.

Regards,
John

>
>>
>> Hi John,
>>
>> I will take a look at the patches this weekend and give feedback beginning of next week. -Will
>>
>>>
>>> Thanks,
>>> John
>>>
>>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>>>
>>>> thanks,
>>>> jirka
>>>>
>>>> .
>
> thanks
> Ganapat
>>>>
>>>
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>

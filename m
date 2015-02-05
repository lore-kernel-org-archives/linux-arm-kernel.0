From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 5 Feb 2015 09:59:45 +0800
Subject: [PATCH -tip/urgent  0/2]kprobes bugfixes around optprobe
In-Reply-To: <54D1FC10.1020505@huawei.com>
References: <20150123064217.30731.49156.stgit@localhost.localdomain>
 <54C5D2CE.5030402@huawei.com> <54D1FC10.1020505@huawei.com>
Message-ID: <54D2CE91.7020704@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

These 2 perf related bugfixs has been acked by Masami Hiramatsu and cc-ed to Ingo
serval weeks ago, but he is not responsive. Could you please help us collect them
into your tree?

Thank you.

On 2015/2/4 19:01, Wang Nan wrote:
> Hi Ingo (and others),
> 
> These 2 bugs still exist in mainline kernel. Could you please have a look at them?
> 
> Thanks!
> 
> On 2015/1/26 13:38, Wang Nan wrote:
>> Hi Ingo,
>>
>> Is there any problem on these patches? I'm unable to find them in upstream kernel
>> and -tip repository.
>>
>> Thank you.
>>
>> On 2015/1/23 14:42, Masami Hiramatsu wrote:
>>> Hi Ingo,
>>>
>>> Here are two patches for fixing bugs in kprobes, related to
>>> optprobe and enable/disable kprobe knob.
>>>
>>> These are reported and fixed by Wang Nan.
>>> https://lkml.org/lkml/2015/1/5/270
>>> https://lkml.org/lkml/2015/1/19/680
>>>
>>> Thank you,
>>>
>>>
>>> ---
>>>
>>> Wang Nan (2):
>>>       [BUGFIX]kprobes: set kprobes_all_disarmed earlier to enable re-optimization.
>>>       [BUGFIX]kprobes: makes kprobes/enabled works correctly for optimized kprobes.
>>>
>>>
>>>  kernel/kprobes.c |   18 +++++++++++++++---
>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> --
>>> Masami HIRAMATSU
>>> Software Platform Research Dpt. Linux Technology Center
>>> Hitachi, Ltd., Yokohama Research Laboratory
>>> E-mail: masami.hiramatsu.pt at hitachi.com
>>>
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

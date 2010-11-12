From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 12 Nov 2010 12:26:24 +0900
Subject: [PATCH] ARM: Common GIC entry macro code V2
In-Reply-To: <AANLkTinXXUxFsS7LttQSJ_AOf2=8+_phSfmW5tyc5GD=@mail.gmail.com>
References: <20101111074955.29633.80160.sendpatchset@t400s>
	<AANLkTimJfZwRx_H4KC+WfXeYONiUMN39VfnT9R54Sh4c@mail.gmail.com>
	<04d401cb8183$e0921500$a1b63f00$%kim@samsung.com>
	<AANLkTinXXUxFsS7LttQSJ_AOf2=8+_phSfmW5tyc5GD=@mail.gmail.com>
Message-ID: <AANLkTimVRqJO6C6XLXeYFz8Eg6J6kq_Dzem76YyYbRce@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 11, 2010 at 6:51 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Thu, Nov 11, 2010 at 6:36 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Kyungmin Park wrote:
>>>
>>> Can you include the "arch/arm/mach-s5pv310/include/mach/entry-macro.S"
>> also?
>>>
>> In conclusion, can't it now.
>> Because according to current interrupt number structure of Samsung SoCs,
>> irqnr macro need to add S5P_IRQ_OFFSET, 32.
>>
>> Or have to add #ifdef in there...But don't like it.
>
> I wonder why Samsung goes another way, use the common codes. if
> required, modify to use the common codes.

Yes, it would be nice if Samsung could use the common code as well. I
will however ignore this for now to focus on getting something merged
that most people can use. The Samsung bits can be dealt with
incrementally.

Thanks,

/ magnus

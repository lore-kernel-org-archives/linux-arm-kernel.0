From: eric.miao@linaro.org (Eric Miao)
Date: Mon, 15 Aug 2011 14:32:28 +0800
Subject: No mach-type for SHEEVAD?
In-Reply-To: <CAMPhdO9YR2Ofxr=NnjardjhUU=HC-Vj17VAbp+yW=qW8wQtxcw@mail.gmail.com>
References: <CACRpkdYi-EfCC0Lnx9bdYXyChzOhosO1C5gmggEnnBsDnzBukA@mail.gmail.com>
	<CAMPhdO8KgWBub5xS=JhLRum+D-=3=7s2oLNSKbWSbht3f=5A_w@mail.gmail.com>
	<CACRpkdYvJR2QoQLjDuKuUOMArgotZ1mSiqmCWwL+th5NS7zJSQ@mail.gmail.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C05D7174A89@SC-VEXCH1.marvell.com>
	<CAMPhdO9YR2Ofxr=NnjardjhUU=HC-Vj17VAbp+yW=qW8wQtxcw@mail.gmail.com>
Message-ID: <CAMPhdO_uNJny7Rsu_j0BKMaa8KgSd8kOWhqZ75jrz4f8EiG2KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 1:28 PM, Eric Miao <eric.miao@linaro.org> wrote:
> 2011/8/15 Haojian Zhuang <hzhuang1@marvell.com>:
>>
>>
>>>-----Original Message-----
>>>From: Linus Walleij [mailto:linus.walleij at linaro.org]
>>>Sent: 2011?8?12? 9:20 PM
>>>To: Eric Miao
>>>Cc: linux-arm-kernel at lists.infradead.org; Haojian Zhuang; Tanmay
>>>Upadhyay
>>>Subject: Re: No mach-type for SHEEVAD?
>>>
>>>On Thu, Aug 4, 2011 at 11:22 AM, Eric Miao <eric.miao@linaro.org> wrote:
>>>> On Thu, Aug 4, 2011 at 10:17 AM, Linus Walleij
>>><linus.walleij@linaro.org> wrote:
>>>>> I tried to configure the mmp2 to build the "gplugd" variant
>>>>> found in the arch/arm/mach-mmp2/gplugd.c source file,
>>>>> however it fails miserably:
>>>>>
>>>>> arch/arm/mach-mmp/gplugd.c:183: error: 'MACH_TYPE_SHEEVAD' undeclared
>>>>> here (not in a function)
>>>>> make[3]: *** [arch/arm/mach-mmp/gplugd.o] Error 1
>>>>
>>>> Hi Russell,
>>>>
>>>> ISTR this entry will be there once the cleanup of mach-types is done?
>>>Or
>>>> we can submit a new entry for this?
>>>
>>>Is this getting anywhere? Torvald's HEAD is still broken
>>>for gplugD. Shall I submit a new machine type so it
>>>atleast gets fixed in the next merge window?
>>>
>>>Thanks,
>>>Linus Walleij
>>
>> Hi Linus,
>>
>> I suggest you to register the machine SHEEVAD in this link. (http://www.arm.linux.org.uk/developer/machines)
>
> Tanmay mentioned it would appear in 3.1 yet it doesn't seem so.
> It's actually not Linus' duty to register this. I'll go ahead with the
> registration, although I'm not sure if there's still chance for this
> to get into 3.1-rcX. Will at least be in 3.2.

Interestingly, gplugd has already been registered in the machine database
by Ofer.

2625	GURU_PLUGD	gplugd	Ofer Zaarur	mainlined

>
>>
>> Thanks
>> Haojian
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>

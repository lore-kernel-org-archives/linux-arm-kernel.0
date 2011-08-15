From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Sun, 14 Aug 2011 22:06:35 -0700
Subject: No mach-type for SHEEVAD?
In-Reply-To: <CACRpkdYvJR2QoQLjDuKuUOMArgotZ1mSiqmCWwL+th5NS7zJSQ@mail.gmail.com>
References: <CACRpkdYi-EfCC0Lnx9bdYXyChzOhosO1C5gmggEnnBsDnzBukA@mail.gmail.com>
	<CAMPhdO8KgWBub5xS=JhLRum+D-=3=7s2oLNSKbWSbht3f=5A_w@mail.gmail.com>
	<CACRpkdYvJR2QoQLjDuKuUOMArgotZ1mSiqmCWwL+th5NS7zJSQ@mail.gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05D7174A89@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Linus Walleij [mailto:linus.walleij at linaro.org]
>Sent: 2011?8?12? 9:20 PM
>To: Eric Miao
>Cc: linux-arm-kernel at lists.infradead.org; Haojian Zhuang; Tanmay
>Upadhyay
>Subject: Re: No mach-type for SHEEVAD?
>
>On Thu, Aug 4, 2011 at 11:22 AM, Eric Miao <eric.miao@linaro.org> wrote:
>> On Thu, Aug 4, 2011 at 10:17 AM, Linus Walleij
><linus.walleij@linaro.org> wrote:
>>> I tried to configure the mmp2 to build the "gplugd" variant
>>> found in the arch/arm/mach-mmp2/gplugd.c source file,
>>> however it fails miserably:
>>>
>>> arch/arm/mach-mmp/gplugd.c:183: error: 'MACH_TYPE_SHEEVAD' undeclared
>>> here (not in a function)
>>> make[3]: *** [arch/arm/mach-mmp/gplugd.o] Error 1
>>
>> Hi Russell,
>>
>> ISTR this entry will be there once the cleanup of mach-types is done?
>Or
>> we can submit a new entry for this?
>
>Is this getting anywhere? Torvald's HEAD is still broken
>for gplugD. Shall I submit a new machine type so it
>atleast gets fixed in the next merge window?
>
>Thanks,
>Linus Walleij

Hi Linus,

I suggest you to register the machine SHEEVAD in this link. (http://www.arm.linux.org.uk/developer/machines)

Thanks
Haojian

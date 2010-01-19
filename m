From: mogambo.kztrj@gmail.com (Khushhua Mogambo)
Date: Tue, 19 Jan 2010 20:57:03 +0900
Subject: Use of data types
In-Reply-To: <4B546900.3020506@ru.mvista.com>
References: <2703439e1001180443t761947e0idc144ced64ca3a4f@mail.gmail.com>
	<20100118134120.GB31345@pengutronix.de>
	<20100118134215.GB16182@darwin> <4B546900.3020506@ru.mvista.com>
Message-ID: <2703439e1001190357r65a507d2v668bbfca1a07c176@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 10:58 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Matthias Kaehlcke wrote:
>
>>>> Hi
>>>> ?I starting to port Linux kernel to my companies new ARM based
>>>> SoC and development board.
>>>>
>>>> Some of the regs is 16bits wide and some is 32bits width. I ask if
>>>> my using u16 and u32 in place of 'unsigned short' and 'unsigned int'
>>>> in the whole porting would be acceptable or not?
>>>>
>>>> In different wording, using only u16 and u32 always is considered good
>>>> quality or bad?
>>>>
>>>
>>> I prefer using u32 over int. ?Still more if your register space isn't
>>> uniform.
>>>
>>
>> ditto
>>
>> how about using the C99 types uint32_t, ... in the kernel?
>
> ?They are actually used in some places but this is generally frowned upon.
> They are for userspace.
>
> WBR, Sergei

from thread, i understand that u32 is encouraged whenever we have reason. I m
going to use u8,16,32 heavily.

Thanks to every one who replied and helped me.

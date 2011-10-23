From: zdevai@gmail.com (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:37:08 +0200
Subject: [PATCH v2 1/5] ARM: SPMP8000: Add machine base files
In-Reply-To: <1409922.Ostx0EbfK3@wuerfel>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1319040118-29773-1-git-send-email-zoss@devai.org>
	<1319040118-29773-2-git-send-email-zoss@devai.org>
	<1409922.Ostx0EbfK3@wuerfel>
Message-ID: <CAGVye5PR3rDbGOf48sPtnZHJXPCa_eY1JqeUZKyeLGk4s_LNHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/19 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 19 October 2011 18:01:54 Zoltan Devai wrote:
>> Files needed for the basic machine support of SPMP8000
>>
>> Signed-off-by: Zoltan Devai <zoss@devai.org>
>
> Hi Zoltan,
>
> This version looks very nice, only a few small things remain that I noticed
> reading through it again:
OK, will correct these.

What's next then ?
I assume I'd need some more review on at least the dts file.
Also, can the timer code go through your tree into drivers/clocksource ?

Thanks,
Zoltan

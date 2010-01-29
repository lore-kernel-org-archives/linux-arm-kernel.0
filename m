From: albin.tonnerre@gmail.com (Albin Tonnerre)
Date: Fri, 29 Jan 2010 16:29:56 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <20100129151402.GD27577@pengutronix.de>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<20100129144601.GA27577@pengutronix.de> <20100129150345.GA5876@laptop>
	<20100129151402.GD27577@pengutronix.de>
Message-ID: <bbb699fe1001290729g730a4d8cs31fbe2de18820ecd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/29 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Fri, Jan 29, 2010 at 04:04:15PM +0100, Albin Tonnerre wrote:
>> On Fri, 29 Jan 2010 15:46 +0100, Uwe Kleine-K?nig wrote :
>> > Maybe the new implementation needs more stack space? ?If so it might
>> > help to increase the stack size. ?(This is defined in the last line of
>> > arch/arm/boot/compressed/head.S. ?If you change the value be sure to
>> > adapt the value just before the LC1 label in the same file, too.)
>>
>> If so, the decompressor would exit with an error message stating that it can't
>> allocate enough memory, so I doubt this is the cause.
> I havn't investigated but I wonder how a stack overflow would be
> detected.

Meh, I misread your message and thought 'malloc space' instead of
'stack size', sorry.

Regards,
-- 
Albin Tonnerre

From: mogambo.kztrj@gmail.com (Khushhua Mogambo)
Date: Wed, 20 Jan 2010 21:15:13 +0900
Subject: Use of data types
In-Reply-To: <20100119174245.GA1886@n2100.arm.linux.org.uk>
References: <2703439e1001180443t761947e0idc144ced64ca3a4f@mail.gmail.com>
	<20100118134120.GB31345@pengutronix.de>
	<20100118134215.GB16182@darwin> <4B546900.3020506@ru.mvista.com>
	<2703439e1001190357r65a507d2v668bbfca1a07c176@mail.gmail.com>
	<20100119174245.GA1886@n2100.arm.linux.org.uk>
Message-ID: <2703439e1001200415u1ba829bag643d9aded5e6d4b7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 2:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 19, 2010 at 08:57:03PM +0900, Khushhua Mogambo wrote:
>> from thread, i understand that u32 is encouraged whenever we have reason. I m
>> going to use u8,16,32 heavily.
>
> Incorrect.
>
> As I said, use u8,u16,u32 when you need something that's of that size
> (eg, for storing values from hardware registers.) ?If you don't require
> something of a specific size, then don't use them.
ok I undrstand. thanking you very much.

From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 31 Dec 2009 09:04:31 +0800
Subject: [RFC] preliminary support for sparse IRQ
In-Reply-To: <20091230193211.GA11446@pengutronix.de>
References: <f17812d70912272103p72765d66v1c77a081d00a1158@mail.gmail.com>
	<20091230193211.GA11446@pengutronix.de>
Message-ID: <f17812d70912301704s559d4023v27986934e3d9b89b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/12/31 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Eric,
>
>> index c6c57b6..747f4ad 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>> @@ -629,7 +629,7 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
>>
>> ?static int __init parse_tag_cmdline(const struct tag *tag)
>> ?{
>> - ? ? strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
>> + ? ? //strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
> I think this hunk isn't intended?
>

Nah, this is a lazy-man's trick to override the passed command line :-)

// embarrassed

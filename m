From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Dec 2009 20:32:11 +0100
Subject: [RFC] preliminary support for sparse IRQ
In-Reply-To: <f17812d70912272103p72765d66v1c77a081d00a1158@mail.gmail.com>
References: <f17812d70912272103p72765d66v1c77a081d00a1158@mail.gmail.com>
Message-ID: <20091230193211.GA11446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

> index c6c57b6..747f4ad 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -629,7 +629,7 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
> 
>  static int __init parse_tag_cmdline(const struct tag *tag)
>  {
> -	strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
> +	//strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
I think this hunk isn't intended?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

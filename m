From: wellsk40@gmail.com (Kevin Wells)
Date: Thu, 19 Aug 2010 11:30:47 -0700
Subject: ARM: LPC32XX: Various minor fixes and updates
In-Reply-To: <20100819085855.GA2747@pengutronix.de>
References: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
	<20100819085855.GA2747@pengutronix.de>
Message-ID: <AANLkTinJ6MWFEAE8cMFWM9L7jJjOqb=Wj_ganrEUX96Z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> This patch set updates and fixes some minor LPC32xx issues.
>>
>> [PATCH 1/6] ARM: LPC32XX: Fix several clock device ID strings
>> [PATCH 2/6] ARM: LPC32XX: Fix naming convention issues with some defines
>> [PATCH 3/6] ARM: LPC32xx: Fix gpiolib bit mask macro
>> [PATCH 4/6] ARM: LPC32xx: Remove MMC peripheral clock enable/disable code
>> [PATCH 5/6] ARM: LPC32XX: Remove clock enable code for AMBA driver
>> [PATCH 6/6] ARM: LPC32XX: Add board.h for platform_data structures
>
> This looks confusing for me. Those patches come from your branch
> 'lpc32xx_up1' but some of them are also contained in
> 'wells/lpc32xx-arch_up1' which you already posted. So, this looks like a
> V2 of the series to me or am I wrong? If so, what has changed and why?
>

Hi Wolfram,
Thanks for the feedback. This is a v2 patch. I'll post a changelog in a bit.

> If I might add, the increasing number of branches makes it hard to
> decide what is currently needed for a board-support; maybe a
> "for-mainline"-branch or something similar with all
> "state-of-the-art"-branches merged might help here?
>

I'm going to post future patch sets for review without providing a GIT link
on our server until it's ready for mainline. This makes it a bit easier for me
too and this seems to be more the standard approach.

thanks,
Kevin

> Kind regards,
>
> ? Wolfram
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkxs8k8ACgkQD27XaX1/VRs9fgCfezrJWYfKdfZOiQaQwsETzQSl
> F3IAnRoykTiPrA2hke4I59gcAYyWFxRL
> =iApV
> -----END PGP SIGNATURE-----
>
>

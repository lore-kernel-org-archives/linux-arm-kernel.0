From: schwab@linux-m68k.org (Andreas Schwab)
Date: Fri, 03 Sep 2010 21:45:37 +0200
Subject: [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <20100903193309.GC29821@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
	=?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Fri, 3 Sep 2010 21:33:09 +0200")
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<20100903192907.GA2978@n2100.arm.linux.org.uk>
	<20100903193309.GC29821@pengutronix.de>
Message-ID: <m2r5ha7gri.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> Still GNU patch should then already fail in --dry-run mode.

Since --dry-run doesn't actually perform any changes it can easily be
fooled when a file is patched twice.

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

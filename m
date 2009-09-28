From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 28 Sep 2009 21:03:51 +0200
Subject: [PATCH] Fix bcmring compile
In-Reply-To: <9383297B60843144AC17878B479520F110AEE538F9@SJEXCHCCR01.corp.ad.broadcom.com>
References: <1254163190-2306-1-git-send-email-linus.walleij@stericsson.com>
	<9383297B60843144AC17878B479520F110AEE538F9@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0D5C1F43@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Scott]

> The core.c for bcmring was based on mach-versatile.
> We missed removing this unused include.  
> An easy fix - Thanks.

That's Acked-by: Scott Branden <sbranden@broadcom.com>
I presume? (That will make it officially approved by
the mach maintainer in my eyes you know...)

Linus Walleij

From: vapier.adi@gmail.com (Mike Frysinger)
Date: Fri, 18 Feb 2011 16:42:34 -0500
Subject: [PATCH] kbuild: reenable section mismatch analysis
In-Reply-To: <1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110216200734.GA25184@merkur.ravnborg.org>
	<1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTinNT05b4YNdTvUF3jRqA=zob7KPT1_Vcic5vxQh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/18 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> This was disabled in commit
>
> ? ? ? ?e5f95c8 (kbuild: print only total number of section mismatces found)
>
> because there were too many warnings. ?Now we're down to a reasonable
> number again, so we start scaring people with the details.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

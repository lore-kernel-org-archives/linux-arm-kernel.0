From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 10 Jun 2010 17:55:10 +0800
Subject: [PATCH 2/5] [ARM] Remove unused INITRD_PHYS from
	arch/arm/boot/compressed
In-Reply-To: <20100610082716.GA3422@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-3-git-send-email-eric.miao@canonical.com>
	<20100610082716.GA3422@pengutronix.de>
Message-ID: <AANLkTinTbYyoMzQ8hgNPL9UF_7XSMxTJkICO8zVsCcm9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Thu, Jun 03, 2010 at 03:36:50PM +0800, Eric Miao wrote:
>> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Original patch from Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>.
>>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Eric Miao <eric.miao@canonical.com>
> The patch is OK, but the commit log of my patch was (IMHO) better.
> Something like:
>
> Only arch/arm/boot/bootp/init.S uses initrd_phys, so there is no need to
> pass it in arch/arm/boot/compressed.
>

OK.

> And I would prefer not to have this "Original patch from ..." in the
> commit log. ?Do you use it because the patch system doesn't offer to
> specify the author of a commit?

It's actually a common practice by many other who I cannot remember.
But yeah, it's there because I need to remind me it's not my patch and
don't get the author wrong :-)

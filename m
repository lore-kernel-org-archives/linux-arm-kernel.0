From: schwab@suse.de (Andreas Schwab)
Date: Thu, 07 Aug 2014 17:33:22 +0200
Subject: [PATCH] cpufreq: arm_big_little: fix module license spec
In-Reply-To: <20140807152934.GT1933@pengutronix.de> ("Uwe =?utf-8?Q?Kleine?=
 =?utf-8?Q?-K=C3=B6nig=22's?=
 message of "Thu, 7 Aug 2014 17:29:34 +0200")
References: <mvmmwbqateb.fsf@hawking.suse.de>
 <1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <mvmiom48knf.fsf@hawking.suse.de>
 <20140807152934.GT1933@pengutronix.de>
Message-ID: <mvmegws8gcd.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> Does adding
>
> 	#include <linux/module.h>
>
> in that file fix the problem?

Yes, it does.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

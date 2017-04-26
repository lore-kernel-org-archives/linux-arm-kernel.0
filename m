From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 26 Apr 2017 13:00:04 +0200
Subject: reset: Use devm_kcalloc() in ti_syscon_reset_probe()?
In-Reply-To: <1493198391.3653.4.camel@pengutronix.de>
References: <e10a20a2-cfea-5b42-db3a-41b6eb08d7e4@users.sourceforge.net>
 <1493198391.3653.4.camel@pengutronix.de>
Message-ID: <5a59a0ca-488a-8d19-2681-ff516c3622e6@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thank you, I have applied this to the reset/next branch.

Thanks for your acceptance.


> The same change could be made in the ti-syscon reset driver.

I was unsure if a similar source code adjustments would be worthwhile there.
If you would like to be more strict with consistent usage of Linux functions
for array allocations, there are various further update candidates to consider.

Regards,
Markus

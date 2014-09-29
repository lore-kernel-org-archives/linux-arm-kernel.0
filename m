From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 29 Sep 2014 08:26:55 +0200
Subject: [PATCH 0/3] Fixes for CNS3xxx platform
In-Reply-To: <201409252343.52997.arnd@arndb.de> (Arnd Bergmann's message of
 "Thu, 25 Sep 2014 23:43:52 +0200")
References: <m3d2av3lgt.fsf@t19.piap.pl> <201409252343.52997.arnd@arndb.de>
Message-ID: <m3sijbaqmo.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> I ended up putting your patches into the next/fixes-non-critical branch,
> which we will submit for 3.18, not 3.17, because by now it is very late
> in the cycle and we mainly want to fix regressions against 3.16. Let us
> know if there is a strong reason to have them in 3.17 after all.

No problem. I mentioned 3.17 because it was at a bit earlier stage then.

> On a related note, Anton Vorontsov mentioned that he can no longer maintain
> cns3xxx upstream, would you mind becoming the official contact? If that's
> ok with you, please send an update for the MAINTAINERS file listing yourself
> and any co-maintainers (Felix?) as well as the level of support you can give
> ("Maintained" or "Odd Fixes" I guess).

Will do.

BTW, as Stephen and Russell pointed out, I've misplaced the UART
CONFIG_* address. I will send a corrected patch shortly.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 23:43:52 +0200
Subject: [PATCH 0/3] Fixes for CNS3xxx platform
In-Reply-To: <m3d2av3lgt.fsf@t19.piap.pl>
References: <m3d2av3lgt.fsf@t19.piap.pl>
Message-ID: <201409252343.52997.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 September 2014, Krzysztof Ha?asa wrote:
> All of this stuff has been tested on Gateworks Laguna platform,
> masqueraded as the CNS3xxx devel board, with v3.17-rc5. I guess this is
> v3.17 material, though it doesn't make much sense for "stable" branches.

Thanks a lot for your bug fixes!

Sorry for the delay, but as both Olof and I were attending Linaro Connect
last week, we had built up a large backlog to look at.

I ended up putting your patches into the next/fixes-non-critical branch,
which we will submit for 3.18, not 3.17, because by now it is very late
in the cycle and we mainly want to fix regressions against 3.16. Let us
know if there is a strong reason to have them in 3.17 after all.

On a related note, Anton Vorontsov mentioned that he can no longer maintain
cns3xxx upstream, would you mind becoming the official contact? If that's
ok with you, please send an update for the MAINTAINERS file listing yourself
and any co-maintainers (Felix?) as well as the level of support you can give
("Maintained" or "Odd Fixes" I guess).

	Arnd

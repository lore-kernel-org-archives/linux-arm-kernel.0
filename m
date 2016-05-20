From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2016 14:04:01 +0200
Subject: [GIT PULL 0/7] ARM: SoC changes for 4.7
In-Reply-To: <CAL_JsqKcVN-KcJnBhqoMpoBjJk4KiPgbWXzA1FR+vh5_bL6oYg@mail.gmail.com>
References: <8749147.ztcb6kVhye@wuerfel>
 <CAL_JsqKcVN-KcJnBhqoMpoBjJk4KiPgbWXzA1FR+vh5_bL6oYg@mail.gmail.com>
Message-ID: <39566023.glxaClBiC0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 May 2016 11:02:56 Rob Herring wrote:
> I happen have a script... (I run it every time people complain about DT).
> 
> Here's the diffstat of mach-* and plat-* since merging DT support:
> 
> v3.0: 833 files changed, 10945 insertions(+), 37476 deletions(-)
> v3.1: 955 files changed, 17796 insertions(+), 20300 deletions(-)
> v3.2: 1507 files changed, 32960 insertions(+), 33392 deletions(-)
> v3.3: 1301 files changed, 27725 insertions(+), 18941 deletions(-)
> v3.4: 1324 files changed, 27079 insertions(+), 21500 deletions(-)
> v3.5: 975 files changed, 32340 insertions(+), 46663 deletions(-)
> v3.6: 648 files changed, 16121 insertions(+), 13161 deletions(-)
> v3.7: 1389 files changed, 23739 insertions(+), 61097 deletions(-)
> v3.8: 1066 files changed, 32812 insertions(+), 40821 deletions(-)
> v3.9: 1031 files changed, 10051 insertions(+), 33399 deletions(-)
> v3.10: 831 files changed, 15049 insertions(+), 27333 deletions(-)
> v3.11: 675 files changed, 18519 insertions(+), 30012 deletions(-)
> v3.12: 474 files changed, 12575 insertions(+), 25120 deletions(-)
> v3.13: 491 files changed, 11088 insertions(+), 13375 deletions(-)
> v3.14: 408 files changed, 5586 insertions(+), 12691 deletions(-)
> v3.15: 538 files changed, 7809 insertions(+), 9337 deletions(-)
> v3.16: 499 files changed, 6528 insertions(+), 10252 deletions(-)
> v3.17: 596 files changed, 6274 insertions(+), 36824 deletions(-)
> v3.18: 333 files changed, 3111 insertions(+), 6905 deletions(-)
> v3.19: 435 files changed, 6180 insertions(+), 32402 deletions(-)
> v4.0: 265 files changed, 4081 insertions(+), 14119 deletions(-)
> v4.1: 362 files changed, 4286 insertions(+), 24876 deletions(-)
> v4.2: 292 files changed, 3115 insertions(+), 11567 deletions(-)
> v4.3: 306 files changed, 3223 insertions(+), 14510 deletions(-)
> v4.4: 160 files changed, 2014 insertions(+), 4893 deletions(-)
> v4.5: 531 files changed, 3839 insertions(+), 4398 deletions(-)
> v4.6: 211 files changed, 1417 insertions(+), 4320 deletions(-)
> 
> Once this goes to 0, we can move the dts files out of the kernel and
> make you maintainer. 
> 
> The dts files' numbers do look pretty constant.

Ah nice. I've done the statistics before (last time for ELC 2015 when
I did a presentation on this), but the last few lines look particularly
nice.

It's also worth comparing this to the earlier times, as by 2.6.39 we
had already started some large-scale cleanups:

This is v2.6.32..v2.6.39:
 3215 files changed, 345665 insertions(+), 100550 deletions(-)

	Arnd

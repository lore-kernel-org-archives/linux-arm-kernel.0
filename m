From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 May 2015 00:03:08 +0200
Subject: [PATCH] rtc: armada38x: remove unused variables
In-Reply-To: <2116673.Ym6IPoTTaZ@wuerfel>
References: <2116673.Ym6IPoTTaZ@wuerfel>
Message-ID: <20150512220308.GT3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/05/2015 at 00:00:33 +0200, Arnd Bergmann wrote :
> A recent bugfix introduced a new compiler warning in the rtc-armada38x
> driver:
> 
> drivers/rtc/rtc-armada38x.c: In function 'armada38x_rtc_read_time':
> drivers/rtc/rtc-armada38x.c:67:34: warning: unused variable 'flags' [-Wunused-variable]
>   unsigned long time, time_check, flags;
> 
> This removes the now obsolete variables to get rid of the warning.
> As the orginal fix was marked for stable backports [4.0], this one
> should be backported as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 489405fe5ed38 ("rtc: armada38x: fix concurrency access in armada38x_rtc_set_time")
> Cc: stable at vger.kernel.org
> 

That one has already been sent by Gregory ;)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

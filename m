From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Nov 2011 15:05:29 +0000
Subject: [V1 3/3] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <1322219217-1866-1-git-send-email-jtzhou@marvell.com>
References: <1322219217-1866-1-git-send-email-jtzhou@marvell.com>
Message-ID: <201111251505.29823.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 November 2011, Jett.Zhou wrote:
> Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
> almost the same, so re-arch the rtc-sa1100 to support them.
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
>  arch/arm/mach-pxa/devices.c    |   20 +++
>  arch/arm/mach-sa1100/generic.c |   20 +++
>  drivers/rtc/Kconfig            |    2 +-
>  drivers/rtc/rtc-sa1100.c       |  276 ++++++++++++++++++++++++++++------------
>  4 files changed, 238 insertions(+), 80 deletions(-)

I looked through the series and found nothing to complain about ;-)

Excellent cleanup!

Acked-by: Arnd Bergmann <arnd@arndb.de>

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 10:33:24 +0900
Subject: [PATCH 0/4] Pending S3C64xx updates
In-Reply-To: <20120124213127.GH1135@opensource.wolfsonmicro.com>
References: <20120124213127.GH1135@opensource.wolfsonmicro.com>
Message-ID: <016501ccdc93$ae158190$0a4084b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
Hi Mark,

> This patch series is a collection of s3c64xx updates I've had hanging
> round in my tree for varying lengths of time that it'd be good to get
> merged.  There's no particularly relationship between them except that
> they're all for s3c64xx.
> 
OK, see my comments below.

> Mark Brown (4):
>       ARM: S3C64XX: Make s3c64xx_init_uarts() static

As I commented, I have pushed this into rmk's patch system but not applied
yet. I discarded that just now in there so that I can apply this in my tree.

>       ARM: S3C64XX: Define some additional always off clocks

Hmm, I know there were discussions about this with Tomasz Figa and I was
waiting for his submitting. But now this looks ok to me so will apply this.

>       ARM: S3C6410: Use device names for both I2C clocks

OK, will apply and let me sort out the #ifdef in Samsung stuff for single
zImage later.

>       ARM: S3C64XX: Add hookup for Tomatin module on Cragganmore

Already in my next/board-samsung.

> 
>  arch/arm/mach-s3c64xx/clock.c                |  106
> ++++++++++++++++++++++++++
>  arch/arm/mach-s3c64xx/common.c               |    2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |   27 ++++++-
>  arch/arm/mach-s3c64xx/mach-crag6410.c        |   11 +++-
>  4 files changed, 143 insertions(+), 3 deletions(-)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

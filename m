From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 7 Mar 2011 10:15:16 +0200
Subject: [PATCH 2/2] ARM: s3c24xx: Switch to common GPIO controlled UDC
	pullup implementation
In-Reply-To: <1299483720-18175-2-git-send-email-lars@metafoo.de>
References: <1299483720-18175-1-git-send-email-lars@metafoo.de>
	<1299483720-18175-2-git-send-email-lars@metafoo.de>
Message-ID: <201103071015.17295.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 March 2011 09:42:00 Lars-Peter Clausen wrote:
> Currently all boards using the s3c2410_udc driver use a GPIO to control the
> state of the pullup, as a result the same code is reimplemented in each
> board This patch changes these boards to use the common implementation for
> GPIO controlled pullup in the UDC driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  arch/arm/mach-s3c2410/mach-h1940.c    |   24 +-----------------------
>  arch/arm/mach-s3c2410/mach-n30.c      |   21 +--------------------
>  arch/arm/mach-s3c2412/mach-smdk2413.c |   24 +-----------------------
>  arch/arm/mach-s3c2440/mach-gta02.c    |   22 ++--------------------
>  arch/arm/mach-s3c2440/mach-mini2440.c |   24 +-----------------------
>  arch/arm/mach-s3c2440/mach-rx1950.c   |   21 +--------------------
>  6 files changed, 7 insertions(+), 129 deletions(-)

For h1940 and rx1950 parts:

Acked-by: Vasily Khoruzhick <anarsoul@gmail.com>

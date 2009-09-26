From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Sat, 26 Sep 2009 10:03:35 -0400 (EDT)
Subject: [PATCH] ARM: Remove unused CONFIG reference DEBUG_S3C_PORT
In-Reply-To: <1253973658.4568.10.camel@ht.satnam>
References: <1253973658.4568.10.camel@ht.satnam>
Message-ID: <alpine.LFD.2.00.0909261002400.19973@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Sep 2009, Jaswinder Singh Rajput wrote:

>
> Remove unused CONFIG reference DEBUG_S3C_PORT from defconfig
>
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> Cc: Byungho Min <bhmin@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk+lkml@arm.linux.org.uk>
> ---
>  arch/arm/configs/s5pc100_defconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/configs/s5pc100_defconfig b/arch/arm/configs/s5pc100_defconfig
> index b0d7d3d..94edde5 100644
> --- a/arch/arm/configs/s5pc100_defconfig
> +++ b/arch/arm/configs/s5pc100_defconfig
> @@ -859,7 +859,6 @@ CONFIG_DEBUG_ERRORS=y
>  # CONFIG_DEBUG_STACK_USAGE is not set
>  CONFIG_DEBUG_LL=y
>  # CONFIG_DEBUG_ICEDCC is not set
> -CONFIG_DEBUG_S3C_PORT=y
>  CONFIG_DEBUG_S3C_UART=0

  no, there is no point removing redundant entries from any of the
defconfig files -- those files will eventually be rebuilt
automatically at some point.

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================

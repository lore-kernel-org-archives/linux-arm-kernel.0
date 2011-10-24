From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 24 Oct 2011 13:37:05 +0200
Subject: [PATCH v2 4/9] serial: samsung: remove struct
	's3c24xx_uart_clksrc' and all uses of it
In-Reply-To: <1318241285-23568-5-git-send-email-thomas.abraham@linaro.org>
References: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
	<1318241285-23568-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20111024113705.GI8708@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 03:38:00PM +0530, Thomas Abraham wrote:
> With clkdev based clock lookup added to samsung serial driver, the use
> of 'struct s3c24xx_uart_clksrc' to supply clock names in platform
> data is removed from all the Samsung platform code.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Ramax Lo <ramaxlo@gmail.com>
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos4/init.c                     |   15 +----------
>  arch/arm/mach-s3c2410/mach-bast.c                |   22 ---------------
>  arch/arm/mach-s3c2410/mach-vr1000.c              |   24 -----------------
>  arch/arm/mach-s3c2440/mach-anubis.c              |   22 +--------------
>  arch/arm/mach-s3c2440/mach-at2440evb.c           |   22 +--------------
>  arch/arm/mach-s3c2440/mach-osiris.c              |   24 ++---------------
>  arch/arm/mach-s3c2440/mach-rx1950.c              |   18 ++----------
>  arch/arm/mach-s3c2440/mach-rx3715.c              |   19 ++-----------
>  arch/arm/mach-s5p64x0/init.c                     |   31 ----------------------
>  arch/arm/mach-s5pv210/init.c                     |   19 -------------
>  arch/arm/plat-samsung/include/plat/regs-serial.h |   23 ----------------
>  drivers/tty/serial/samsung.h                     |    1 -
>  12 files changed, 14 insertions(+), 226 deletions(-)

Nice diffstat.  :-)

g.

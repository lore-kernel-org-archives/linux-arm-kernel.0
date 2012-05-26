From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 May 2012 09:33:56 +0100
Subject: [PATCH 2/6] amba: use the new linux/sizes.h
In-Reply-To: <0e1b40d651ffbc654616173f2c3bf89888db21a5.1337959750.git.rubini@gnudd.com>
References: <cover.1337959750.git.rubini@gnudd.com>
 <0e1b40d651ffbc654616173f2c3bf89888db21a5.1337959750.git.rubini@gnudd.com>
Message-ID: <20120526083356.GD24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 05:48:12PM +0200, Alessandro Rubini wrote:
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  drivers/amba/bus.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index b7e7285..e29bfa7 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -18,7 +18,7 @@
>  #include <linux/amba/bus.h>
>  
>  #include <asm/irq.h>
> -#include <asm/sizes.h>
> +#include <linux/sizes.h>

Please move this up alongside the other linux/ includes.

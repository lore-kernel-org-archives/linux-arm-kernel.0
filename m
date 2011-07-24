From: jj@chaosbits.net (Jesper Juhl)
Date: Sun, 24 Jul 2011 09:51:47 +0200 (CEST)
Subject: [PATCH] ARM:mach-dove:remove the dup include serial_8250.h
In-Reply-To: <1311477872-4329-1-git-send-email-wanlong.gao@gmail.com>
References: <1311477872-4329-1-git-send-email-wanlong.gao@gmail.com>
Message-ID: <alpine.LNX.2.00.1107240950550.5758@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 24 Jul 2011, Wanlong Gao wrote:

> From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 
> linux/serial_8250.h has been included for twice.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  arch/arm/mach-dove/common.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index 5ed51b8..b6c3d6b 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -17,7 +17,6 @@
>  #include <linux/clk.h>
>  #include <linux/mbus.h>
>  #include <linux/ata_platform.h>
> -#include <linux/serial_8250.h>
>  #include <linux/gpio.h>
>  #include <asm/page.h>
>  #include <asm/setup.h>
> 

A patch for this is already in linux-next: 
http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=4ca9d7856c101f4b1d2c7d3f2ad2fcce8e9a20ae
"ARM: remove duplicate include from arch/arm/mach-dove/common.c"

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

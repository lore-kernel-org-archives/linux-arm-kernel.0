From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Mar 2011 17:35:30 +0900
Subject: [PATCH 2/4] ARM: S5P: remove duplicated #include
In-Reply-To: <1300457202-264-1-git-send-email-weiyi.huang@gmail.com>
References: <1300457202-264-1-git-send-email-weiyi.huang@gmail.com>
Message-ID: <000501cbeac7$9e7f3780$db7da680$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huang Weiyi wrote:
> 
> Remove duplicated #include('s) in
>   arch/arm/mach-s5pv210/mach-smdkv210.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> ---
>  arch/arm/mach-s5pv210/mach-smdkv210.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-
> s5pv210/mach-smdkv210.c
> index bc08ac4..c6a9e86 100644
> --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> @@ -44,7 +44,6 @@
>  #include <plat/keypad.h>
>  #include <plat/pm.h>
>  #include <plat/fb.h>
> -#include <plat/gpio-cfg.h>
>  #include <plat/s5p-time.h>
> 
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
> --
> 1.6.1.3

Oops...ok, applied :)
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

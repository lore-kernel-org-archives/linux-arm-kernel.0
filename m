From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Thu, 23 Jun 2011 16:01:53 -0700
Subject: [PATCH 07/37] Remove unneeded version.h includes from
 arch/arm/
In-Reply-To: <alpine.LNX.2.00.1106240007150.17688@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
	<alpine.LNX.2.00.1106240007150.17688@swampdragon.chaosbits.net>
Message-ID: <4E03C5E1.5090209@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/23/2011 3:08 PM, Jesper Juhl wrote:
> It was pointed out by 'make versioncheck' that some includes of
> linux/version.h are not needed in arch/arm/.
> This patch removes them.
>
> Signed-off-by: Jesper Juhl<jj@chaosbits.net>
> ---
>   arch/arm/mach-bcmring/irq.c   |    1 -
>   arch/arm/mach-bcmring/timer.c |    1 -
>   2 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-bcmring/irq.c b/arch/arm/mach-bcmring/irq.c
> index c48feaf..437fa68 100644
> --- a/arch/arm/mach-bcmring/irq.c
> +++ b/arch/arm/mach-bcmring/irq.c
> @@ -20,7 +20,6 @@
>   #include<linux/stddef.h>
>   #include<linux/list.h>
>   #include<linux/timer.h>
> -#include<linux/version.h>
>   #include<linux/io.h>
>
>   #include<mach/hardware.h>
> diff --git a/arch/arm/mach-bcmring/timer.c b/arch/arm/mach-bcmring/timer.c
> index 2d415d2..af9c3d7 100644
> --- a/arch/arm/mach-bcmring/timer.c
> +++ b/arch/arm/mach-bcmring/timer.c
> @@ -12,7 +12,6 @@
>   * consent.
>   *****************************************************************************/
>
> -#include<linux/version.h>
>   #include<linux/types.h>
>   #include<linux/module.h>
>   #include<csp/tmrHw.h>

Acked-by: Jiandong Zheng <jdzheng@broadcom.com>

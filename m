From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 19 Jun 2013 16:22:21 +0530
Subject: [PATCH v2 1/7] gpio: davinci: coding style correction
In-Reply-To: <1371202532-14628-2-git-send-email-avinashphilip@ti.com>
References: <1371202532-14628-1-git-send-email-avinashphilip@ti.com>
 <1371202532-14628-2-git-send-email-avinashphilip@ti.com>
Message-ID: <51C18D65.6010009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2013 3:05 PM, Philip Avinash wrote:
> Make some minor coding style fixes. Use proper multi-line
> commenting style, arrange include files alphabetically use
> macros for bit definitions.

Its a register offset, not bit definition.

> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Changes since v1:
> 	- Remove variable name replacement
> 	- Add line break after BINTEN macro definition
> 
>  drivers/gpio/gpio-davinci.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 17df6db..e8d189c 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -9,12 +9,12 @@
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>   */
> -#include <linux/gpio.h>
> -#include <linux/errno.h>
> -#include <linux/kernel.h>
> +

This is unnecessary empty line. I made these fixes locally and added
this to my v3.11/gpio branch.

Thanks,
Sekhar

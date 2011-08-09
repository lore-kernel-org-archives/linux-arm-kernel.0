From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 09 Aug 2011 16:06:14 +0400
Subject: [PATCH 06/13] ARM: gpio: davinci: convert drivers to use
	asm/gpio.h rather than mach/gpio.h
In-Reply-To: <E1QqhKP-0003aK-9R@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhKP-0003aK-9R@rmk-PC.arm.linux.org.uk>
Message-ID: <4E4122B6.2070706@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-08-2011 12:06, Russell King - ARM Linux wrote:

    CCing linux-usb and Felipe...

> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---
>   drivers/usb/musb/davinci.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
> index 8bdf25a..f9a3f62 100644
> --- a/drivers/usb/musb/davinci.c
> +++ b/drivers/usb/musb/davinci.c
> @@ -35,7 +35,7 @@
>
>   #include<mach/hardware.h>
>   #include<mach/memory.h>
> -#include<mach/gpio.h>
> +#include<asm/gpio.h>

    Shouldn't this now be moved to the below #include group?

>   #include<mach/cputype.h>
>
>   #include<asm/mach-types.h>

WBR, Sergei

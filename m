From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 01 Aug 2011 13:52:54 +0400
Subject: [PATCH V2 03/20] dmaengine/amba-pl08x: Rearrange inclusion of
	header files in ascending order
In-Reply-To: <16f5abd9452832860f3a11fe1ddabde05fa3ae8c.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
	<16f5abd9452832860f3a11fe1ddabde05fa3ae8c.1312190881.git.viresh.kumar@st.com>
Message-ID: <4E367776.1070008@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-08-2011 13:37, Viresh Kumar wrote:

> Header files included in driver are not present in alphabetical order. Rearrange
> them in alphabetical order.

> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   drivers/dma/amba-pl08x.c |   17 ++++++++---------
>   1 files changed, 8 insertions(+), 9 deletions(-)

> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 4c4a309..8e2056b 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -74,19 +74,18 @@
>    * Global TODO:
>    * - Break out common code from arch/arm/mach-s3c64xx and share
>    */
> -#include<linux/device.h>
> -#include<linux/init.h>
> -#include<linux/module.h>
> -#include<linux/interrupt.h>
> -#include<linux/slab.h>
> -#include<linux/delay.h>
> -#include<linux/dmapool.h>
> -#include<linux/dmaengine.h>
>   #include<linux/amba/bus.h>
>   #include<linux/amba/pl08x.h>
>   #include<linux/debugfs.h>
> +#include<linux/delay.h>
> +#include<linux/device.h>
> +#include<linux/dmaengine.h>
> +#include<linux/dmapool.h>
> +#include<linux/init.h>
> +#include<linux/interrupt.h>
> +#include<linux/module.h>
>   #include<linux/seq_file.h>
> -
> +#include<linux/slab.h>

    Shouldn't there be emoty line here?

>   #include<asm/hardware/pl080.h>

WBR, Sergei

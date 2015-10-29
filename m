From: wenyou.yang@atmel.com (Yang, Wenyou)
Date: Thu, 29 Oct 2015 09:52:27 +0800
Subject: [PATCH v2 03/14] clk: at91: make use of syscon/regmap internally
In-Reply-To: <1444660131-14954-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1444660131-14954-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <56317BDB.1050209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/10/12 22:28, Alexandre Belloni wrote:
> diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.c
> index 61566bcefa53..a0fe54a96031 100644
> --- a/drivers/clk/at91/clk-h32mx.c
> +++ b/drivers/clk/at91/clk-h32mx.c
> @@ -24,6 +24,9 @@
>   #include <linux/irq.h>
>   #include <linux/sched.h>
>   #include <linux/wait.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
Repeated  #include <linux/regmap.h> .


Best Regards,
Wenyou Yang

From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 26 Jan 2013 19:21:32 +0400
Subject: [PATCH v6 1/2] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <1359168322-17733-2-git-send-email-rtivy@ti.com>
References: <1359168322-17733-1-git-send-email-rtivy@ti.com>
 <1359168322-17733-2-git-send-email-rtivy@ti.com>
Message-ID: <5103F47C.4020509@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-01-2013 6:45, Robert Tivy wrote:

> Adding a remoteproc driver implementation for OMAP-L138 DSP

> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> new file mode 100644
> index 0000000..c6eb6bf
> --- /dev/null
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -0,0 +1,327 @@
[...]
> +#define SYSCFG_CHIPSIG_OFFSET 0x174
> +#define SYSCFG_CHIPSIG_CLR_OFFSET 0x178

    Wait, you don't even use these #define's -- why they're here at all?

WBR, Sergei

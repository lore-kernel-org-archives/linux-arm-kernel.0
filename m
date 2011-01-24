From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 10:17:01 +0000
Subject: [PATCH] ARM: pxa: fix suspend on PXA3XX
In-Reply-To: <1295864152-773-1-git-send-email-s.neumann@raumfeld.com>
References: <20110124095138.GC16202@n2100.arm.linux.org.uk>
	<1295864152-773-1-git-send-email-s.neumann@raumfeld.com>
Message-ID: <20110124101701.GE16202@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 11:15:52AM +0100, Sven Neumann wrote:
>  static struct pxa_cpu_pm_fns pxa3xx_cpu_pm_fns = {
> +        .save           = pxa3xx_cpu_pm_save,
> +        .restore        = pxa3xx_cpu_pm_restore,

Indentation error.

>  	.valid		= pxa3xx_cpu_pm_valid,
>  	.enter		= pxa3xx_cpu_pm_enter,
>  };
k

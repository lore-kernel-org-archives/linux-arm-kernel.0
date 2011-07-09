From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 9 Jul 2011 04:01:32 +0100
Subject: [PATCH 04/10] ASoc: mxs: add asoc configuration files
In-Reply-To: <1310140790-2132-5-git-send-email-b29396@freescale.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-5-git-send-email-b29396@freescale.com>
Message-ID: <20110709030132.GE26900@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 11:59:44PM +0800, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

*Always* CC maintainers on patches.

> @@ -57,6 +57,7 @@ source "sound/soc/s6000/Kconfig"
>  source "sound/soc/sh/Kconfig"
>  source "sound/soc/tegra/Kconfig"
>  source "sound/soc/txx9/Kconfig"
> +source "sound/soc/mxs/Kconfig"

Keep all these files sorted.  

From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 4 Jan 2017 13:29:46 +0800
Subject: [PATCH v5 1/4] soc: zte: Add header for PM domains specifiers
In-Reply-To: <1483489157-10782-1-git-send-email-baoyou.xie@linaro.org>
References: <1483489157-10782-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170104052945.GE20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 08:19:14AM +0800, Baoyou Xie wrote:
> This patch adds header with values used for ZTE 2967
> SoC's power domain driver.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

The tags like Reviewed-by, Acked-by etc, can only be added into your
patch after people give it explicitly.  One of the examples is that Jun
Nie gave his Reviewed-by tag on your "[PATCH v2 2/2] soc: zte:
pm_domains: Add support for zx296718 board".

https://www.spinics.net/lists/arm-kernel/msg547282.html

I did not give my Reviewed-by tag on list, so you shouldn't add it here.
Actually, in case of this patch series, I will probably apply them
through ZTE -> arm-soc tree, when I feel it's ready.  So I'm do not even
need to give the Reviewed-by tag.

Shawn

> ---
>  include/dt-bindings/soc/zte,pm_domains.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 include/dt-bindings/soc/zte,pm_domains.h
> 
> diff --git a/include/dt-bindings/soc/zte,pm_domains.h b/include/dt-bindings/soc/zte,pm_domains.h
> new file mode 100644
> index 0000000..01e9abc
> --- /dev/null
> +++ b/include/dt-bindings/soc/zte,pm_domains.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2017 Linaro Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +#ifndef _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H
> +#define _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H
> +
> +#define DM_ZX296718_SAPPU	0
> +#define DM_ZX296718_VDE		1  /* g1v6 */
> +#define DM_ZX296718_VCE		2  /* h1v6 */
> +#define DM_ZX296718_HDE		3  /* g2v2 */
> +#define DM_ZX296718_VIU		4
> +#define DM_ZX296718_USB20	5
> +#define DM_ZX296718_USB21	6
> +#define DM_ZX296718_USB30	7
> +#define DM_ZX296718_HSIC	8
> +#define DM_ZX296718_GMAC	9
> +#define DM_ZX296718_TS		10
> +#define DM_ZX296718_VOU		11
> +
> +#endif /* _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H */
> -- 
> 2.7.4
> 

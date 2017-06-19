From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 05:59:13 +0200
Subject: [PATCH v5 21/26] soc: actions: Add Owl SPS
In-Reply-To: <20170619034021.5762-1-afaerber@suse.de>
References: <20170606005426.26446-24-afaerber@suse.de>
 <20170619034021.5762-1-afaerber@suse.de>
Message-ID: <c5df0116-b09a-0389-b616-b2b0046ab0c6@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.06.2017 um 05:40 schrieb Andreas F?rber:
> Implement S500 Smart Power System power-gating.
> For now flag PD_CPU2 and PD_CPU3 as always-on.
> 
> Based on LeMaker linux-actions tree.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v4 -> v5:
>  * Updated for header file rename
>  
>  v3 -> v4:
>  * Added genpd_flags field and set GENPD_FLAG_ALWAYS_ON for CPU2/CPU3
>  * Added debug output
>  
>  v3: new
>  
>  drivers/soc/Kconfig           |   1 +
>  drivers/soc/Makefile          |   1 +
>  drivers/soc/actions/Kconfig   |  12 ++
>  drivers/soc/actions/Makefile  |   1 +
>  drivers/soc/actions/owl-sps.c | 252 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 267 insertions(+)
>  create mode 100644 drivers/soc/actions/Kconfig
>  create mode 100644 drivers/soc/actions/Makefile
>  create mode 100644 drivers/soc/actions/owl-sps.c

Applied to linux-actions.git v4.13/soc branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/soc

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)

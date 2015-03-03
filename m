From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 3 Mar 2015 04:39:36 +0000 (UTC)
Subject: [PATCH v2 1/3] ARM: OMAP2: hwmod: AM43XX: Add hwmod support for
 HDQ-1W
In-Reply-To: <1425293374-30878-2-git-send-email-vigneshr@ti.com>
References: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
 <1425293374-30878-2-git-send-email-vigneshr@ti.com>
Message-ID: <alpine.DEB.2.02.1503030439090.29683@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Mar 2015, Vignesh R wrote:

> From: "Poddar, Sourav" <sourav.poddar@ti.com>
> 
> These adds hwmod data for hdq/1w driver on AM43xx.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> Change log:
> v2:
>  * Add SYSC_HAS_AUTOIDLE flag.
> 
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 36 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm43xx.h             |  1 +
>  2 files changed, 37 insertions(+)
> 

Thanks, queued for v4.1.


- Paul

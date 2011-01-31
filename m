From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 31 Jan 2011 10:46:46 -0700 (MST)
Subject: [PATCH] OMAP: powerdomain: remove unused func declaration
In-Reply-To: <1295446960-24358-1-git-send-email-rnayak@ti.com>
References: <1295446960-24358-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1101311045410.10420@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jan 2011, Rajendra Nayak wrote:

> Trivial fix to remove the unused function declaration
> from the powerdomain header.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index c66431e..0b7a357 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -165,7 +165,6 @@ struct pwrdm_ops {
>  	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
>  };
>  
> -void pwrdm_fw_init(void);
>  void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops *custom_funcs);
>  
>  struct powerdomain *pwrdm_lookup(const char *name);
> -- 
> 1.7.0.4

For the archives, this patch was queued for 2.6.39 as part of the 
pwrdm_clkdm_a_2.6.39 branch on git://git.pwsan.com/linux-2.6


- Paul

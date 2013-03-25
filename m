From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Mar 2013 15:36:03 +0100
Subject: [PATCH] ARM: AT91: Fix typo in restart code panic message
In-Reply-To: <1364032738-6371-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364032738-6371-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130325143603.GC20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:58 Sat 23 Mar     , Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 4b67847..6b4608d 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -333,7 +333,7 @@ static void at91_dt_rstc(void)
>  
>  	of_id = of_match_node(rstc_ids, np);
>  	if (!of_id)
> -		panic("AT91: rtsc no restart function availlable\n");
> +		panic("AT91: rtsc no restart function available\n");
>  
>  	arm_pm_restart = of_id->data;
>  
> -- 
> 1.7.10.4
> 

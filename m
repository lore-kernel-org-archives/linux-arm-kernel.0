From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Dec 2010 10:26:24 -0800
Subject: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
In-Reply-To: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
Message-ID: <20101216182624.GH5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* jean.pihet at newoldbits.com <jean.pihet@newoldbits.com> [101216 09:51]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> This patch only contains clean-ups and cosmetic changes,
> no functional change.
> 
> Clean-up of the ASM sleep code, for better readability and
> easier maintenance.
> 
> Applies on top of Nishant's latest idle path errata fixes step 2,
> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
> 
> Jean Pihet (7):
>   OMAP2+: use global values for the SRAM PA addresses
>   OMAP3: remove hardcoded values from the ASM sleep code
>   OMAP3: re-organize the ASM sleep code
>   OMAP3: rework of the ASM sleep code execution paths
>   OMAP3: add comments for low power code errata
>   OMAP3: ASM sleep code format rework
>   OMAP3: remove unused code from the ASM sleep code

Thanks for splitting it into several patches, looks good to me.
Assuming Kevin will queue these, so:

Acked-by: Tony Lindgren <tony@atomide.com>

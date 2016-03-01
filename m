From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Mar 2016 10:11:10 -0800
Subject: [PATCH v3 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
In-Reply-To: <1456439796-28546-3-git-send-email-fcooper@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-3-git-send-email-fcooper@ti.com>
Message-ID: <20160301181109.GB13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
> From: Vignesh R <vigneshr@ti.com>
> 
> Add hwmod entries for the PWMSS on DRA7.
> 
> Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
> equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
> As per AM57x TRM SPRUHZ6[1], October 2014, Section 29.1.3 Table 29-4,
> clock source to PWMSS is L4PER2_L3_GICLK. But it is actually
> L4PER2_L3_GICLK/2. The TRM does not show the division by 2.
> 
> [1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf

Looks OK to me, assuming Paul will pick this one or ack it.

FYI, the URL above is outdated, looks like there's spruhz7a.pdf
available. Not sure if that's been corrected for the divider?

Regards,

Tony

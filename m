From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 Mar 2016 06:45:11 +0000 (UTC)
Subject: [PATCH v5 4/6] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
In-Reply-To: <1457400224-24797-5-git-send-email-fcooper@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-5-git-send-email-fcooper@ti.com>
Message-ID: <alpine.DEB.2.02.1603080644580.4974@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Mar 2016, Franklin S Cooper Jr wrote:

> From: Vignesh R <vigneshr@ti.com>
> 
> Add hwmod entries for the PWMSS on DRA7.
> 
> Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
> equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> [fcooper at ti.com: Do not add eQEP, ePWM and eCAP hwmod entries]
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Thanks, queued for v4.7.

- Paul

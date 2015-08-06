From: Govindraj.Raja@imgtec.com (Govindraj Raja)
Date: Thu, 6 Aug 2015 09:05:52 +0000
Subject: [RFC PATCH v4 3/9] mips: pistachio_defconfig: remove
 CONFIG_MMC_DW_IDMAC
In-Reply-To: <1438843515-23935-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843515-23935-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <4BF5E8683E87FC4DA89822A5A3EB60CB6F2001@hhmail02.hh.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin at rock-chips.com]
> Sent: 06 August 2015 07:45 AM
> To: jh80.chung at samsung.com; ulf.hansson at linaro.org
> Cc: heiko at sntech.de; dianders at chromium.org; Vineet.Gupta1 at synopsys.com;
> Wei Xu; Joachim Eastwood; Alexey Brodkin; Kukjin Kim; Krzysztof Kozlowski;
> Russell King; Jun Nie; Ralf Baechle; Govindraj Raja; linux-arm-
> kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org; linux-
> mips at linux-mips.org; linux-mmc at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-rockchip at lists.infradead.org;
> devicetree at vger.kernel.org; Shawn Lin
> Subject: [RFC PATCH v4 3/9] mips: pistachio_defconfig: remove
> CONFIG_MMC_DW_IDMAC
> 
> DesignWare MMC Controller's transfer mode should be decided at runtime
> instead of compile-time. So we remove this config option and read dw_mmc's
> register to select DMA master.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/mips/configs/pistachio_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Govindraj Raja <govindraj.raja@imgtec.com>

--
Thanks,
Govindraj.R

From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Fri, 7 Aug 2015 05:48:32 +0000
Subject: [RFC PATCH v4 4/9] arc: axs10x_defconfig: remove
 CONFIG_MMC_DW_IDMAC
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843526-23976-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665B17BF@IN01WEMBXB.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 August 2015 12:19 PM, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet

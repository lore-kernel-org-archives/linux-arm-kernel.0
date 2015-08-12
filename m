From: ralf@linux-mips.org (Ralf Baechle)
Date: Thu, 13 Aug 2015 00:05:00 +0200
Subject: [RFC PATCH v4 3/9] mips: pistachio_defconfig: remove
 CONFIG_MMC_DW_IDMAC
In-Reply-To: <1438843515-23935-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843515-23935-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20150812220500.GD11636@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 02:45:15PM +0800, Shawn Lin wrote:

> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/mips/configs/pistachio_defconfig | 1 -

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Please feel free to merge this patch with the remainder
of the series.

  Ralf

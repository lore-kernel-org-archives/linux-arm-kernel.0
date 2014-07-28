From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Mon, 28 Jul 2014 18:33:00 +0200
Subject: [LINUX PATCH] ARM: zynq: DT: Remove DMA from board DTs
In-Reply-To: <1406564643-10417-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1406564643-10417-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <53D67B3C.3050401@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.07.2014 18:24, schrieb Soren Brinkmann:
> The DMA engine is enabled for all DTs that derive from zynq-7000.dtsi.
> There is no need to override the 'status' property in board DTs.
> 
> Cc: Andreas F?rber <afaerber@suse.de>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> When the 'status' property was removed from the DMA node, this had been
> overlooked.

Indeed,

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

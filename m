From: grant.likely@linaro.org (Grant Likely)
Date: Sun, 22 Sep 2013 07:18:28 -0500
Subject: [PATCH 22/51] DMA-API: amba: get rid of separate dma_mask
In-Reply-To: <E1VMm3x-0007hp-Lv@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm3x-0007hp-Lv@rmk-PC.arm.linux.org.uk>
Message-ID: <20130922121828.58F02C42373@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Sep 2013 22:47:01 +0100, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> AMBA Primecell devices always treat streaming and coherent DMA exactly
> the same, so there's no point in having the masks separated.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

for the drivers/of/platform.c portion:
Acked-by: Grant Likely <grant.likely@linaro.org>

g.

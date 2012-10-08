From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 08 Oct 2012 15:15:04 +0200
Subject: [PATCH] ARM: dts: exynos4: Enable serial controllers on Origen and
 SMDKV310
In-Reply-To: <1349701968-6675-1-git-send-email-t.figa@samsung.com>
References: <1349701968-6675-1-git-send-email-t.figa@samsung.com>
Message-ID: <1587144.mixS1B3zoJ@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Monday 08 of October 2012 15:12:48 Tomasz Figa wrote:
> This patch adds status override of serial nodes to enable used serial
> ports on Origen and SMDKV310 board.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts   | 16 ++++++++++++++++
>  arch/arm/boot/dts/exynos4210-smdkv310.dts | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
> 

I think you missed this patch when applying Exynos dts reorganization 
patches. It is needed to enable serial ports on Origen and SMDKV310 boards. 
Could you apply it as well?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center

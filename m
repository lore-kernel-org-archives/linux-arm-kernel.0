From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 5 Nov 2013 09:45:20 -0500
Subject: [PATCH 1/3] ARM: __fixup_smp read of SCU config should do byteswap
 in BE case
In-Reply-To: <1383617765-28052-2-git-send-email-victor.kamensky@linaro.org>
References: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
 <1383617765-28052-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <52790480.20805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 November 2013 09:16 PM, Victor Kamensky wrote:
> Commit "bc41b8724f24b9a27d1dcc6c974b8f686b38d554 ARM: 7846/1:
> Update SMP_ON_UP code to detect A9MPCore with 1 CPU devices"
> added read of SCU config register into __fixup_smp function.
> Such read should be followed by byteswap, if kernel runs in
> BE mode.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

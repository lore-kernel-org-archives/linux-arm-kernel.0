From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 21 Jul 2018 00:15:46 +0200
Subject: [PATCH] i2c: exynos5: Describe the hardware variant for
 readability
In-Reply-To: <20180718195404.5095-1-krzk@kernel.org>
References: <20180718195404.5095-1-krzk@kernel.org>
Message-ID: <20180720221546.obccridrqavnlzfn@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 09:54:04PM +0200, Krzysztof Kozlowski wrote:
> The driver supports multiple hardware variants of Exynos I2C controller
> which differ in FIFO depth, handling of interrupts and bus recovery in
> HSI2C_MASTER_ST_LOSE state.
> 
> The difference in variant was a single bit set for Exynos7 variants and
> implicit lack of this bit for other variants.
> 
> Make each variant explicit which also fixes the GCC warning about
> documentation:
> 
>     drivers/i2c/busses/i2c-exynos5.c:223: warning: Function parameter or member 'hw' not described in 'exynos_hsi2c_variant'
> 
> No change in functionality.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180721/c25967fc/attachment.sig>

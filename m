From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon, 08 Oct 2012 11:15:31 +0900
Subject: [PATCH] ARM: EXYNOS: Remove wrong I2S0 clock from peril clock
In-Reply-To: <004d01cda2cc$37254570$a56fd050$@samsung.com>
References: <004d01cda2cc$37254570$a56fd050$@samsung.com>
Message-ID: <016501cda4fa$caa62dc0$5ff28940$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, Oct 05, 2012 at 4:37 PM, Sangsu Park wrote:
> Remove I2S0 clk from peril since peril clock doesn't have I2S0 clk for EXYNOS4.
> Audio Subsystem block has I2S0 clk.
> 
> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>

Peril control bit 19 is reserved.

Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Thanks,
Sangbeom.

From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 14 Dec 2011 14:25:23 +0800
Subject: [PATCH V3 4/4] arm/imx6q-sabrelite: add enet phy ksz9021rn fixup
In-Reply-To: <1323826007-17937-5-git-send-email-richard.zhao@linaro.org>
References: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
 <1323826007-17937-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111214062523.GD11874@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:26:47AM +0800, Richard Zhao wrote:
> The default phy RGMII pad settings can not work, tune pad skew.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/mach-imx/mach-imx6q.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Regards,
Shawn

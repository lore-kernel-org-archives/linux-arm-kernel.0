From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 14 Dec 2011 14:24:29 +0800
Subject: [PATCH V3 3/4] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <1323826007-17937-4-git-send-email-richard.zhao@linaro.org>
References: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
 <1323826007-17937-4-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111214062429.GC11874@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:26:46AM +0800, Richard Zhao wrote:
> - Add basic board dts file
> - Add board compatible string to mach-imx6q.
> - Update fsl DT board doc.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
>  arch/arm/boot/dts/imx6q-sabrelite.dts         |   49 +++++++++++++++++++++++++
>  arch/arm/mach-imx/mach-imx6q.c                |    1 +
>  3 files changed, 54 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6q-sabrelite.dts

Applied, thanks.

-- 
Regards,
Shawn

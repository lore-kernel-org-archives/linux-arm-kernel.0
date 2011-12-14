From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 14 Dec 2011 14:26:43 +0800
Subject: [PATCH v2] arm/imx6q: Rename Sabreauto to Armadillo2
In-Reply-To: <1323328921-2226-1-git-send-email-dirk.behme@de.bosch.com>
References: <1323328921-2226-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20111214062642.GE11874@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 08:22:01AM +0100, Dirk Behme wrote:
> The Sabreauto board was renamed to Armadillo2 recently. To avoid
> confusion, rename Sabreauto to Armadillo2/arm2.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes in v2: Rebase against the recent mainline
> 
>  Documentation/devicetree/bindings/arm/fsl.txt      |    4 ++--
>  .../dts/{imx6q-sabreauto.dts => imx6q-arm2.dts}    |    4 ++--
>  arch/arm/mach-imx/mach-imx6q.c                     |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/arm/boot/dts/{imx6q-sabreauto.dts => imx6q-arm2.dts} (91%)

Applied, thanks.

-- 
Regards,
Shawn

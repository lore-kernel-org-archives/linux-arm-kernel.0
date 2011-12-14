From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 14 Dec 2011 14:21:07 +0800
Subject: [PATCH V3 1/4] dts/imx: rename gpio labels to consistent with hw
 spec
In-Reply-To: <1323826007-17937-2-git-send-email-richard.zhao@linaro.org>
References: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
 <1323826007-17937-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111214062104.GA11874@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:26:44AM +0800, Richard Zhao wrote:
> GPIO1/GPIO2/... is more readable than GPIO0/GPIO1/... .
> Remove redundant gpio comments.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts   |   11 +++++------
>  arch/arm/boot/dts/imx51.dtsi          |    8 ++++----
>  arch/arm/boot/dts/imx53-ard.dts       |   16 ++++++++--------
>  arch/arm/boot/dts/imx53-evk.dts       |   15 +++++++--------
>  arch/arm/boot/dts/imx53-qsb.dts       |   16 ++++++++--------
>  arch/arm/boot/dts/imx53-smd.dts       |   13 ++++++-------
>  arch/arm/boot/dts/imx53.dtsi          |   14 +++++++-------
>  arch/arm/boot/dts/imx6q-sabreauto.dts |    6 +++---
>  arch/arm/boot/dts/imx6q.dtsi          |   14 +++++++-------
>  9 files changed, 55 insertions(+), 58 deletions(-)
> 
Applied, thanks.

-- 
Regards,
Shawn

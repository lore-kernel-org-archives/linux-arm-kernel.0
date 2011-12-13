From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 Dec 2011 17:41:01 +0800
Subject: [PATCH V2 1/7] dts/imx: rename gpio labels to consistent with hw
 spec
In-Reply-To: <1323757530-19402-2-git-send-email-richard.zhao@linaro.org>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
 <1323757530-19402-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111213094100.GD10866@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 02:25:24PM +0800, Richard Zhao wrote:
> GPIO1/GPIO2/... is more readable than GPIO0/GPIO1/... .
> Remove redundant gpio comments.
> 
If we want to make this change, it's really more than just gpio, all
phandle name numbering should be changed to keep consistency.  You may
want to make the same change on uart as well.

-- 
Regards,
Shawn

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

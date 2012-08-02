From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Aug 2012 09:40:00 +0800
Subject: [PATCH] ARM: imx6q-sabrelite: Setup CLKO IOMUX
In-Reply-To: <1343869868-29490-1-git-send-email-festevam@gmail.com>
References: <1343869868-29490-1-git-send-email-festevam@gmail.com>
Message-ID: <20120802013958.GB2253@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 10:11:08PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> In order to have audio functional on mx6qsabrelite, it is necessary to setup
> the IOMUX for MX6Q_PAD_GPIO_0__CCM_CLKO pins as it provides the audio clock.
> 
The commit messages should generally be wrapped at column 72.  I fixed
it up and queued the patch for 3.6-rc.  Thanks.

-- 
Regards,
Shawn

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index d42e851..1769f44 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -53,6 +53,7 @@
>  						fsl,pins = <
>  							   144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
>  							   121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
> +							   953  0x80000000	/* MX6Q_PAD_GPIO_0__CCM_CLKO */		
>  							   >;
>  					};
>  				};
> -- 
> 1.7.1
> 

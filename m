From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 18 Sep 2018 18:09:59 +0200
Subject: [PATCH 2/2] ARM: dts: imx6qdl-zii-rdu2: Disable the internal RTC
In-Reply-To: <1537271012-5159-2-git-send-email-festevam@gmail.com>
References: <1537271012-5159-1-git-send-email-festevam@gmail.com>
 <1537271012-5159-2-git-send-email-festevam@gmail.com>
Message-ID: <1537286999.3362.144.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 18.09.2018, 08:43 -0300 schrieb Fabio Estevam:
> On the imx6qdl-zii-rdu2 board the RTC functionality is provided via
> a DS1341 RTC connected via I2C bus, so we can safely disable the internal
> one.?
> 
> Reported-by: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++++
> ?1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 7fff371..85e79a3 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -813,6 +813,10 @@
> > ?	status = "okay";
> ?};
> ?
> +&snvs_rtc {
> > +	status = "disabled";
> +};
> +
> ?&ssi1 {
> > ?	status = "okay";
> ?};

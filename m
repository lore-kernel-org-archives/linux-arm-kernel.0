From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 25 Jul 2014 10:48:46 -0300
Subject: [PATCH 2/3] ARM: dts: nitrogen6x: add hdmi
In-Reply-To: <1406285393-23545-2-git-send-email-l.stach@pengutronix.de>
References: <1406285393-23545-1-git-send-email-l.stach@pengutronix.de>
 <1406285393-23545-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAOMZO5BUDMfwDi944brOQoiNkWG_5yBn0XPTPYsLh8_cpyDc3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Fri, Jul 25, 2014 at 7:49 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> From: Michael Olbrich <m.olbrich@pengutronix.de>
>
> Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index 3362d2600d85..4e27cf9f3d2e 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -174,6 +174,12 @@
>         status = "okay";
>  };
>
> +&hdmi {
> +       ddc-i2c-bus = <&i2c2>;
> +       hpd-unreliable;

I don't see this property available in linux-next yet. Are we missing
the patch that adds it?

From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 23 May 2018 11:39:00 -0600
Subject: [PATCH 07/11] dts: juno: Add scatter-gather support for all
 revisions
In-Reply-To: <1526661567-4578-8-git-send-email-suzuki.poulose@arm.com>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
 <1526661567-4578-8-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkz8d_RrFojz=ZQwOBB6J3-W9+edaVWC6R7Arg5GvhwcOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2018 at 10:39, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Advertise that the scatter-gather is properly integrated on
> all revisions of Juno board.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index eb749c5..6ce9090 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -198,6 +198,7 @@
>                 clocks = <&soc_smc50mhz>;
>                 clock-names = "apb_pclk";
>                 power-domains = <&scpi_devpd 0>;
> +               arm,scatter-gather;
>                 port {
>                         etr_in_port: endpoint {
>                                 slave-mode;
> --
> 2.7.4
>

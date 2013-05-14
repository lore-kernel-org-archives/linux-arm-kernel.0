From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 14 May 2013 17:16:29 +0800
Subject: [RFC PATCH v3 11/17] ARM: dts: prima2: cpus/cpu node dts updates
In-Reply-To: <1366824502-19729-12-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366824502-19729-12-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <CAGsJ_4yudJGYqb_uc7=ZKw++g=wnoa4=8ExW_jhY=UF8N4P_jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/25 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>:
> This patch updates the in-kernel dts files according to the latest cpus
> and cpu bindings updates for ARM.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Barry Song <Baohua.Song@csr.com>

> ---
>  arch/arm/boot/dts/prima2.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index 3329719..02edd89 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -18,6 +18,8 @@
>                 #size-cells = <0>;
>
>                 cpu at 0 {
> +                       compatible = "arm,cortex-a9";
> +                       device_type = "cpu";
>                         reg = <0x0>;
>                         d-cache-line-size = <32>;
>                         i-cache-line-size = <32>;
> --

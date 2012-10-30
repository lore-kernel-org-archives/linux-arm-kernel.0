From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 30 Oct 2012 04:36:52 -0700
Subject: [PATCH V2 2/3] clk: armada-370-xp: add support for clock framework
In-Reply-To: <1349125926-16144-3-git-send-email-gregory.clement@free-electrons.com>
References: <1349125926-16144-1-git-send-email-gregory.clement@free-electrons.com>
 <1349125926-16144-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121030113652.18780.45729@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2012-10-01 14:12:05)
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

This didn't apply cleanly to -rc3.  Can you rebase this along with the
respin of patch #1 in the series?

<snip>

> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 71d6b5d..e75f3a2 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -27,6 +27,35 @@
>                     <0xd0021870 0x58>;
>         };
>  
> +       cpus {
> +           #address-cells = <1>;
> +           #size-cells = <0>;
> +
> +           cpu at 0 {
> +               compatible = "marvell,sheeva-v7";

Extra white space in front of compatible.  Should be tabs.

Regards,
Mike

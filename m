From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Feb 2014 20:59:42 +0100
Subject: [PATCH 2/3] mfd: axp20x: Add dtsi for axp20x
In-Reply-To: <1391875428-6281-3-git-send-email-carlo@caione.org>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-3-git-send-email-carlo@caione.org>
Message-ID: <20140210195942.GA3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Sat, Feb 08, 2014 at 05:03:47PM +0100, Carlo Caione wrote:
> This patch adds a new dtsi for supporting axp20x.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/axp20x.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 arch/arm/boot/dts/axp20x.dtsi
> 
> diff --git a/arch/arm/boot/dts/axp20x.dtsi b/arch/arm/boot/dts/axp20x.dtsi
> new file mode 100644
> index 0000000..98d4c7c
> --- /dev/null
> +++ b/arch/arm/boot/dts/axp20x.dtsi
> @@ -0,0 +1,9 @@
> +/*
> +* Integrated Power Management Chip AXP209
> +*/
> +
> +&axp {
> +	compatible = "x-powers,axp20x";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +};

Hmmm, this refers to an undefined node, I can't see this DTSI used
anywhere, and why do you need a DTSI of its own in the first place?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/b62a7ee4/attachment.sig>

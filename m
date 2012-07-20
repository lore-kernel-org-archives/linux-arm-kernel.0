From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Jul 2012 11:01:13 +0100
Subject: [PATCH RESEND 2/4] ARM: OMAP2+: AM33XX: Add tps65217 device tree
 data
In-Reply-To: <1342766789-28148-3-git-send-email-anilkumar@ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-3-git-send-email-anilkumar@ti.com>
Message-ID: <20120720100113.GR4495@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 12:16:27PM +0530, AnilKumar Ch wrote:

> +		dcdc1_reg: regulator at 0 {
> +			reg = <0>;
> +			regulator-compatible = "dcdc1";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1800000>;

Same issue here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120720/fa4d5480/attachment.sig>

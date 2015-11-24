From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Nov 2015 09:45:31 +0100
Subject: [PATCH v2 5/5] ARM: dts: sun8i: Add THS node to the H3 .dtsi
In-Reply-To: <0fff612e26bf9cda9027a4175e16d25a0c2cc62c.1448263428.git.atx@atx.name>
References: <cover.1448263428.git.atx@atx.name>
 <0fff612e26bf9cda9027a4175e16d25a0c2cc62c.1448263428.git.atx@atx.name>
Message-ID: <20151124084531.GK32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 09:02:52AM +0100, Josef Gajdusek wrote:
> +		ths: ths at 01c25000 {
> +			#thermal-sensor-cells = <0>;
> +			compatible = "allwinner,sun8i-h3-ths";
> +			reg = <0x01c25000 0x88>;

The datasheet says the size is 0x400, any particular reason to have a

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/72523515/attachment.sig>

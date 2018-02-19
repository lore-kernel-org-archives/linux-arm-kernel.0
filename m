From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Feb 2018 09:49:44 +0100
Subject: [PATCH v3 5/7] arm: dts: sun8i: a83t: Add CCI-400 node
In-Reply-To: <20180219081837.15482-6-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-6-mylene.josserand@bootlin.com>
Message-ID: <20180219084944.iqrdzhpl63gdf6wy@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 19, 2018 at 09:18:35AM +0100, Myl?ne Josserand wrote:
> +				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;

You should align these blocks on the first one in the array.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180219/7ec2ff17/attachment-0001.sig>

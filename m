From: kaloz@openwrt.org (Imre Kaloz)
Date: Sun, 03 Apr 2016 11:56:36 +0200
Subject: [PATCH] ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500
In-Reply-To: <1459601753-31193-1-git-send-email-bert@biot.com>
References: <1459601753-31193-1-git-send-email-bert@biot.com>
Message-ID: <op.yfb8kmk22s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sat, 02 Apr 2016 14:55:52 +0200, Bert Vermeulen <bert@biot.com> wrote:

> This platform is based on a Marvell 88E6282 SoC and 88E6171 switch.
>
> The DSA port labels follow the switchdev convention.
>
> Signed-off-by: Bert Vermeulen <bert@biot.com>

> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-candyhouse.dts

Candyhouse is the name of the platform, not the router. please use

arch/arm/boot/dts/kirkwood-linksys-viper.dts

> +	model = "Linksys Candyhouse (E4200v2 / EA4500)";
> +	compatible = "linksys,ea4500", "linksys,e4200v2",  
> "marvell,kirkwood-88f6282", "marvell,kirkwood";

The EA4200v2 is the same as the EA4500. The name is viper, so

compatible = "linksys,viper"



Best,

Imre

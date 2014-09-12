From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Sep 2014 14:44:46 +0100
Subject: [PATCH 1/2] ASoC: rockchip-max98090: add documentation for
 rockchip-max98090 driver
In-Reply-To: <1410507036-15442-1-git-send-email-jay.xu@rock-chips.com>
References: <1410506806-15327-1-git-send-email-jay.xu@rock-chips.com>
 <1410507036-15442-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140912134446.GT7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 03:30:36PM +0800, Jianqun wrote:
> Add documentation for rockchip-max98090 driver, which is need by rockchip
> board using a max98090.

Can this use simple-card (perhaps after a bit of extension)?

> +- rockchip,audio-codec : The phandle of the MAX98090 audio codec.

Is the driver really specific to this CODEC?

> +
> +Optional properties:
> +- rockchip,hp-det-gpios : The GPIO that detect headphones are plugged in
> +- rockchip,mic-det-gpios : The GPIO that detect micphones are plugged in
> +
> +Example:
> +
> +sound {
> +	compatible = "rockchip,rockchip-audio-max98090";
> +	rockchip,model = "ROCKCHIP-I2S";
> +	rockchip,i2s-controller = <&i2s>;
> +	rockchip,audio-codec = <&max98090>;
> +	rockchip,hp-det-gpios = <&gpio6 5 GPIO_ACTIVE_HIGH>;
> +	rockchip,mic-det-gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>;
> +};
> -- 
> 1.9.1
> 
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/b931caf2/attachment-0001.sig>

From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Feb 2016 13:57:51 +0000
Subject: [PATCH v2.1 2/4] spi: rockchip: add bindings for rk3399 spi
In-Reply-To: <56C5959D.3030806@rock-chips.com>
References: <1455762983-29980-1-git-send-email-jay.xu@rock-chips.com>
 <1455762983-29980-3-git-send-email-jay.xu@rock-chips.com>
 <20160218094108.GA7129@sirena.org.uk> <2327512.KAqs6H56Km@phil>
 <56C5959D.3030806@rock-chips.com>
Message-ID: <20160218135751.GE7129@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 05:57:49PM +0800, Jianqun Xu wrote:

> I'm a little confuse, I have upstreamed rockchip-i2s, and the i2s driver set
> the compatible like:
> - compatible: should be one of the followings
>    - "rockchip,rk3066-i2s": for rk3066
>    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
>    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
>    - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
> and the driver only has
> static const struct of_device_id rockchip_i2s_match[] = {
> 	{ .compatible = "rockchip,rk3066-i2s", },
> 	{},
> };

> The spi of rk3399 as same as rk3066, rk3188, rk3288, like i2s, if they are
> keep different rules ?

No, that's just something that got missed in review and which should be
fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160218/6cb04dc6/attachment.sig>

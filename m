From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Fri, 19 Feb 2016 10:44:42 +0800
Subject: [PATCH v2.1 2/4] spi: rockchip: add bindings for rk3399 spi
In-Reply-To: <20160218135751.GE7129@sirena.org.uk>
References: <1455762983-29980-1-git-send-email-jay.xu@rock-chips.com>
 <1455762983-29980-3-git-send-email-jay.xu@rock-chips.com>
 <20160218094108.GA7129@sirena.org.uk> <2327512.KAqs6H56Km@phil>
 <56C5959D.3030806@rock-chips.com> <20160218135751.GE7129@sirena.org.uk>
Message-ID: <56C6819A.8090106@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

? 18/02/2016 21:57, Mark Brown ??:
> On Thu, Feb 18, 2016 at 05:57:49PM +0800, Jianqun Xu wrote:
>
>> I'm a little confuse, I have upstreamed rockchip-i2s, and the i2s driver set
>> the compatible like:
>> - compatible: should be one of the followings
>>     - "rockchip,rk3066-i2s": for rk3066
>>     - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
>>     - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
>>     - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
>> and the driver only has
>> static const struct of_device_id rockchip_i2s_match[] = {
>> 	{ .compatible = "rockchip,rk3066-i2s", },
>> 	{},
>> };
>
>> The spi of rk3399 as same as rk3066, rk3188, rk3288, like i2s, if they are
>> keep different rules ?
>
> No, that's just something that got missed in review and which should be
> fixed.
>
Got it, it's will be fixed in a separate patch later, thank you very much.

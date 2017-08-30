From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 31 Aug 2017 01:00:44 +0800
Subject: [RESENT PATCH v7 3/7] arm64: dts: rockchip: Update rt5514 devices'
 compatible for Gru
In-Reply-To: <1649093.IvC24TsujL@diego>
References: <20170824045227.15504-1-jeffy.chen@rock-chips.com>
 <20170824045227.15504-4-jeffy.chen@rock-chips.com> <1649093.IvC24TsujL@diego>
Message-ID: <59A6EF3C.5090308@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

thanks for your reply.

On 08/30/2017 09:30 PM, Heiko St?bner wrote:
>> >-		compatible = "realtek,rt5514";
>> >+		compatible = "realtek,rt5514", "realtek,rt5514-i2c";
> the rt5514-i2c and -spi compatibles should be documented in the binding-txt
> of the chip, but I haven't found any mention of this.
>
>
> Heiko

these compatibles are only used for our snd driver to detect rt5514 i2c 
driver and rt5514 spi driver, suggested by Matthias at 
https://patchwork.kernel.org/patch/9904731/

should i add it in the rockchip,rk3399-gru-sound.txt or rt5514 binding 
document?

From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 18 Jan 2016 18:44:16 +0800
Subject: [PATCH] clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag
 for hclk_vio_bus
In-Reply-To: <1816378.OnNVlMiORS@phil>
References: <1452858854-841-1-git-send-email-ykk@rock-chips.com>
 <1816378.OnNVlMiORS@phil>
Message-ID: <569CC200.1050504@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/18/2016 03:14 AM, Heiko Stuebner wrote:
> Am Freitag, 15. Januar 2016, 19:54:14 schrieb Yakir Yang:
>> HCLK_VIO_BUS is the noc bus controller clock for display module,
>> due to it shouldn't belong to any driver, but we need it enabled,
>> so just mark it as the CLK_IGNORE_UNUSED flag.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> applied to my clk-branch for 4.6

Thanks  ;)

- Yakir
> Thanks
> Heiko
>
>
>

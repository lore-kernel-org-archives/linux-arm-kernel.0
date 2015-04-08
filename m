From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 08 Apr 2015 11:17:29 +0200
Subject: [PATCH 1/1] clk: exynos5420: Restore GATE_BUS_TOP on suspend
In-Reply-To: <5524EFA8.6000800@samsung.com>
References: <1428471252-15872-1-git-send-email-javier.martinez@collabora.co.uk>
 <5524EFA8.6000800@samsung.com>
Message-ID: <5524F229.1060802@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sylwester,

On 04/08/2015 11:06 AM, Sylwester Nawrocki wrote:
>> 
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 07d666cc6a29..bea4a173eef5 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -271,6 +271,7 @@ static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
>>  	{ .offset = SRC_MASK_PERIC0,		.value = 0x11111110, },
>>  	{ .offset = SRC_MASK_PERIC1,		.value = 0x11111100, },
>>  	{ .offset = SRC_MASK_ISP,		.value = 0x11111000, },
>> +	{ .offset = GATE_BUS_TOP,		.value = 0xffffffff, },
>>  	{ .offset = GATE_BUS_DISP1,		.value = 0xffffffff, },
>>  	{ .offset = GATE_IP_PERIC,		.value = 0xffffffff, },
>>  };
> 
> I'm going to tag this patch for inclusion in the stable tree and send
> it to Mike or Stephen with other clk/samsung fixes after v4.1-rc1 is
> released.
> 
> Mike/Stephen, if you're willing to take this patch earlier here is my:
> 
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 

Great, thanks a lot for your help!

Best regards,
Javier

From: andi.shyti@samsung.com (Andi Shyti)
Date: Wed, 08 Jun 2016 16:22:42 +0900
Subject: [PATCH 25/34] clk: s2mps11: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-26-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <CGME20160601231605epcas1p251d4d1f532f7a53a0e58d5c7ee9e6ffc@epcas1p2.samsung.com>
 <20160601231533.9354-26-stephen.boyd@linaro.org>
Message-ID: <20160608072242.GA23808@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Andi Shyti <andi.shyti@samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
> 
> See commit 58657d189a2f and it's children for details on this
> new registration API.
> 
>  drivers/clk/clk-s2mps11.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Acked-by: Andi Shyti <andi.shyti@samsung.com>

Thanks,
Andi

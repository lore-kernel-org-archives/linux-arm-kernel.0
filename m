From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 03 Jun 2016 09:18:21 +0200
Subject: [PATCH 25/34] clk: s2mps11: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-26-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-26-stephen.boyd@linaro.org>
Message-ID: <57512F3D.8090201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2016 01:15 AM, Stephen Boyd wrote:
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

Looks and works correct:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

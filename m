From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 17 Jun 2016 07:59:58 +0200
Subject: [PATCH V2 3/4] clk: max77686: Add DT binding details for PMIC
 MAX77620
In-Reply-To: <1466083407-28793-4-git-send-email-ldewangan@nvidia.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
 <1466083407-28793-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <576391DE.603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 03:23 PM, Laxman Dewangan wrote:
> Maxim has used the same clock IP on multiple PMICs like MAX77686,
> MAX77802, MAX77620. Only differences are the number of clocks
> from these PMICs like MAX77686 has 3 clocks output, MAX776802 have
> two clock output and MAX77620 has one clock output.
> 
> Add clock binding details and DT example for the MAX77620.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> 
> ---
> Changes from V1:
> - Use proper comment for the ::::
> - Added dt binding preprocessor file as maxim,max77620.h for max77620
>   inline with the other chip.
> - Refer the dt binding header for the supported clock index.
> ---
>  .../devicetree/bindings/clock/maxim,max77686.txt   | 52 +++++++++++++++++-----
>  include/dt-bindings/clock/maxim,max77620.h         | 21 +++++++++
>  2 files changed, 63 insertions(+), 10 deletions(-)
>  create mode 100644 include/dt-bindings/clock/maxim,max77620.h

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

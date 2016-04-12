From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 09:35:49 +0200
Subject: [PATCH v9 08/20] PM / devfreq: exynos: Add the detailed
 correlation between sub-blocks and power line
In-Reply-To: <1460347078-15175-9-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-9-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CA555.7020202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the detailed corrleation between sub-blocks and power line

s/corrleation/correlation/


> for Exynos3250, Exynos4210 and Exynos4x12.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)


Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

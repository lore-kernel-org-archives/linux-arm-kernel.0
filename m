From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 13:29:01 +0200
Subject: [PATCH 4/7] dt-bindings: clock: Add the clock id for ACLK clock of
 Exynos542x SoC
In-Reply-To: <1460091646-28701-5-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CDBFD.7080307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
> This patch adds the clock id for ACLK clock of Exynos542x SoC. ACLK clock mean
> the source clock of AMBA AXI bus. This clock id should be used for Bus
> frequency scaling.
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

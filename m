From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 16:05:58 +0200
Subject: [PATCH] arm64: dts: Add nodes for pdma0 and pdam1 for exynos7
In-Reply-To: <1460465378-23486-1-git-send-email-alim.akhtar@samsung.com>
References: <1460465378-23486-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <570D00C6.9000203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2016 02:49 PM, Alim Akhtar wrote:
> This patch adds device tree nodes for pdma0 and pdma1 controllers
> found on exynos7 SoCs.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7.dtsi |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

I would prefer avoid adding all new stuff at the end because it is
conflict-prone. Alphabetical order or by address... but none of these
are used currently. How about putting it after 'gic' node?

Anyway the code looks fine:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

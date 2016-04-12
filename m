From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 16:35:01 +0200
Subject: [RESPIN v2 6/6] ARM: dts: change SROM node compatible from generic
 to model specific
In-Reply-To: <1460360548-32127-7-git-send-email-pankaj.dubey@samsung.com>
References: <1460360548-32127-1-git-send-email-pankaj.dubey@samsung.com>
 <1460360548-32127-7-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <570D0795.3070504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 09:42 AM, Pankaj Dubey wrote:
> This patch changes SROM nodes compatible from generic to model specific
> to match with binding documentation. Also updating property
> "samsung,srom-page-mode" as it is not defined as bool instead of int
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi            | 4 ++--
>  arch/arm/boot/dts/exynos5.dtsi            | 4 ++--
>  arch/arm/boot/dts/exynos5410-smdk5410.dts | 2 +-
>  arch/arm/boot/dts/exynos5410.dtsi         | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 15 Sep 2015 09:00:42 +0900
Subject: [PATCH v2 3/3] ARM: dts: Enable EC vboot context support on Peach
 boards
In-Reply-To: <1442234049-18637-4-git-send-email-emilio.lopez@collabora.co.uk>
References: <1442234049-18637-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1442234049-18637-4-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <55F75FAA.9000007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.09.2015 21:34, Emilio L?pez wrote:
> The Peach boards use the EC to store the vboot context information,
> so add the corresponding properties on the EC node to indicate so.
> 
> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
> ---
> 
> Changes from v1:
>  - none
> 
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 1 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

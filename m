From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 21 Oct 2014 14:04:17 +0200
Subject: [PATCH v2 4/4] ARM: dts: exynos4412-trats: Add suspend
 configuration for max77686 regulators
In-Reply-To: <1413890597-31037-5-git-send-email-k.kozlowski@samsung.com>
References: <1413890597-31037-1-git-send-email-k.kozlowski@samsung.com>
 <1413890597-31037-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54464BC1.40201@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/21/2014 01:23 PM, Krzysztof Kozlowski wrote:
> Add suspend to RAM configuration for max77686 regulators. Some LDOs and
> bucks are disabled. This reduces energy consumption during S2R,
> approximately from 17 mA to 9 mA.
> 
> Additionally remove old and not supported bindings:
>  - regulator-mem-off
>  - regulator-mem-idle
>  - regulator-mem-on
> The max77686 driver does not parse them and they are not documented
> anywere.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts | 72 +++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 30 deletions(-)
> 

I'm not familiar with the board but the change looks good to me assuming each
regulator is doing the right thing.

I already gave you my Reviewed-by for the previous version but was not carried:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier

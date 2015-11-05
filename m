From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 Nov 2015 10:51:28 +0900
Subject: [PATCH V2 5/5] ARM: dts: exynos4412: Rename OPP nodes as
 opp@<opp-hz>
In-Reply-To: <a911512c457ac95b6d8cb46eb631786cb4b64da9.1446687367.git.viresh.kumar@linaro.org>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
 <a911512c457ac95b6d8cb46eb631786cb4b64da9.1446687367.git.viresh.kumar@linaro.org>
Message-ID: <563AB620.5090904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 10:41, Viresh Kumar wrote:
> OPP bindings got updated to name OPP nodes this way, make changes
> according to that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

I see this patch does not depend on the rest of patchset so I presume
this can co through samsung-soc?

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

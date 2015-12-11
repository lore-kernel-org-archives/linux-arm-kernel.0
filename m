From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 15:24:55 +0900
Subject: [PATCH] ARM: dts: Make CPU configuration more readable for
 exynos542x/5800
In-Reply-To: <20151211062143.GT3612@ubuntu>
References: <1449814657-25685-1-git-send-email-k.kozlowski@samsung.com>
 <20151211062143.GT3612@ubuntu>
Message-ID: <566A6C37.30603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 15:21, Viresh Kumar wrote:
> On 11-12-15, 15:17, Krzysztof Kozlowski wrote:
>> Exynos5420 and Exynos5800 boards boot from big core (A15) but
>> Exynos5420 boards choose otherwise: LITTLE core (A7) (on Exynos5422 this
> 
> s/Exynos5420/Exynos5422

Damn, one can get confused.

Thanks for review!
Krzysztof

> and then you can add
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

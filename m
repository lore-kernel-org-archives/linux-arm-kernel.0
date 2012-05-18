From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 18 May 2012 10:20:01 +0200
Subject: [PATCH 1/2] ARM: EXYYNOS: Use EXYNOS4210_GPEx instead of
 EXYNOS4_GPEx
In-Reply-To: <4FB5B9A1.2030606@samsung.com>
References: <1337307497-15777-1-git-send-email-jy0922.shim@samsung.com>
 <4FB5B9A1.2030606@samsung.com>
Message-ID: <4FB60631.4050609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2012 04:53 AM, Joonyoung Shim wrote:
> Add to cc Grant Likely and Linus Walleij
> 
> On 05/18/2012 11:18 AM, Joonyoung Shim wrote:
>> Also use EXYNOS4210_GPIO_Ex instead of EXYNOS4_GPIO_Ex. The GPEx gpios
>> exist only on Exynos4210 and there are no on Exynos4x12. Redefine them
>> to exact SoC name.
>>
>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

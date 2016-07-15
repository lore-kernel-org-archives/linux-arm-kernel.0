From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 15 Jul 2016 10:28:27 +0200
Subject: [PATCH] media: Doc add missing documentation for
 samsung,exynos4212-jpeg
In-Reply-To: <57889C23.3050106@samsung.com>
References: <1468526499-8840-1-git-send-email-shuahkh@osg.samsung.com>
 <578890BA.8040101@samsung.com> <57889B73.4090607@samsung.com>
 <57889C23.3050106@samsung.com>
Message-ID: <57889EAB.30502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2016 10:17 AM, Krzysztof Kozlowski wrote:
> On 07/15/2016 10:14 AM, Jacek Anaszewski wrote:
>>> However if these compatibles are exactly equal then
>>> only one should be preferred. It makes everything easier. Second can be
>>> still documented e.g. as deprecated.
>>
>> Still, both of them are present in the driver. Shouldn't it be reflected
>> in the documentation?
>
> Right, it is a good practice, so how about:
>
>    - compatible    : should be one of:
>            "samsung,s5pv210-jpeg", "samsung,exynos3250-jpeg",
>            "samsung,exynos4210-jpeg", "samsung,exynos5420-jpeg",
>            "samsung,exynos5433-jpeg";
>
>            Deprecated: "samsung,exynos4212-jpeg"
>
> (or any other formatting)
> plus update to DTS changing it to 4210?

Why newer 4212 version should be made deprecated?

-- 
Best regards,
Jacek Anaszewski

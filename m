From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 7 May 2015 18:19:05 +0900
Subject: [RFT PATCH v2 0/3] drm/exynos: Fix build breakage on
 !DRM_EXYNOS_FIMD
In-Reply-To: <554B2D8A.6070209@collabora.co.uk>
References: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
 <554B2D8A.6070209@collabora.co.uk>
Message-ID: <CAJKOXPdbBAGk+QFLY3YmwUhfDr6iY6s5AsD-oaVBFcGtXqVd0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-07 18:16 GMT+09:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
> Hello Krzysztof,
>
> On 05/07/2015 02:04 AM, Krzysztof Kozlowski wrote:
>> From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>
>> Hi,
>>
>> This is second try to fix the build breakage introduced in 1c363c7cccf6
>> ("drm/exynos: Enable DP clock to fix display on Exynos5250 and other").
>>
>> The fix is not trivial so I am kindly asking for testing on Chromebook
>> and other DP-enabled boards (I don't have Chromebook right now).
>>
>
> For all the series:
>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
>> Tested on Exynos4412 Trats2 board.
>>
>
> On Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi Chromebooks:
>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks, your help is appreciated.
Krzysztof

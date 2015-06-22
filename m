From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 22 Jun 2015 09:31:15 +0900
Subject: [PATCH 4/6] ARM: dts: Exynos4210: add CPU OPP and regulator
 supply property
In-Reply-To: <CAJKOXPfR5JS546YS3M-8orxO7+SxnzE06h2cyesExyt8Y9fVKw@mail.gmail.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
 <1428079429-4252-5-git-send-email-b.zolnierkie@samsung.com>
 <CAJKOXPfR5JS546YS3M-8orxO7+SxnzE06h2cyesExyt8Y9fVKw@mail.gmail.com>
Message-ID: <CAJKOXPfdXV8qxR3AQEzQJTf6MojUN7Z=06ikxF8u5BuMihDfJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-08 9:18 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> 2015-04-04 1:43 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> For Exynos4210 platforms, add CPU operating points and CPU
>> regulator supply properties for migrating from Exynos specific
>> cpufreq driver to using generic cpufreq driver.
>>
>> Changes by Bartlomiej:
>> - removed Exynos5250 and Exynos5420 support for now
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Cc: Andreas Faerber <afaerber@suse.de>
>> Cc: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Andreas Farber <afaerber@suse.de>
>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Rebased and applied to my tree, I'll sent it later to Kukjin unless he
picks it by himself from LKML.

Best regards,
Krzysztof

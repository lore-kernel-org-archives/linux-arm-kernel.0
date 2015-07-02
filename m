From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 2 Jul 2015 13:14:40 +0200
Subject: [PATCH v3 2/4] ARM: dts: Exynos5250: add CPU OPP and regulator
 supply property
In-Reply-To: <55947D93.3090606@samsung.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
 <1435756238-845-3-git-send-email-b.zolnierkie@samsung.com>
 <55947D93.3090606@samsung.com>
Message-ID: <CABxcv=njwtCfE92LXMX27zQHR5qBt3+Pc54nzYK3nXvEsawK9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 2, 2015 at 1:53 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 01.07.2015 22:10, Bartlomiej Zolnierkiewicz wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> For Exynos5250 platforms, add CPU operating points and CPU
>> regulator supply properties for migrating from Exynos specific
>> cpufreq driver to using generic cpufreq driver.
>>
>> Changes by Bartlomiej:
>> - split Exynos5250 support from the original patch
>> - added CPU regulator supply property for Google Spring board
>> - put the new cpu nodes in alphabetical order
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Cc: Javier Martinez Canillas <javier@dowhile0.org>
>> Cc: Andreas Faerber <afaerber@suse.de>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5250-arndale.dts  |  4 ++++
>>  arch/arm/boot/dts/exynos5250-smdk5250.dts |  4 ++++
>>  arch/arm/boot/dts/exynos5250-snow.dts     |  4 ++++
>>  arch/arm/boot/dts/exynos5250-spring.dts   |  4 ++++
>>  arch/arm/boot/dts/exynos5250.dtsi         | 22 ++++++++++++++++++++++
>>  5 files changed, 38 insertions(+)
>
> Looks good, thanks!
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

and on an Exynos5250 Snow Chromebook:

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier

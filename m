From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 21 May 2014 16:44:04 +0530
Subject: [PATCH 2/3] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <1635304.bK37Q0Q4AO@amdc1032>
References: <1400655169-21683-1-git-send-email-sachin.kamat@linaro.org>
 <1400655169-21683-3-git-send-email-sachin.kamat@linaro.org>
 <1635304.bK37Q0Q4AO@amdc1032>
Message-ID: <CAK9yfHxj-z1bWQqiaWVwvL2yRotqZn86ecjKcoHcyMQHZCrVcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

On 21 May 2014 16:06, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Wednesday, May 21, 2014 12:22:48 PM Sachin Kamat wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> This makes it possible to enable the exynos platform as part of a
>> multiplatform kernel, in addition to keeping the single-platform
>> Exynos support.
>
> The patch description is wrong.  After this patch single-platform Exynos
> support is no longer available

Forgot to update the message while rebasing. Thanks for noticing.

> and it adds at least one serious regression

I have mentioned about this in the cover letter.

> (cpufreq) which should be fixed before merging this patch.  Moreover it
> seems that this patch (#2) should be merged with patch #3 to preserve
> bisectability.

At this point exynos_defconfig works.

>Please also note that exynos_defconfig is no longer useful
> after these changes and can be be removed.

Yes.

---
With warm regards,
Sachin

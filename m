From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 5 Sep 2011 15:43:08 +0530
Subject: [PATCH 2/2] arm: samsung: remove sdhci default configuration
	setup platform helper
In-Reply-To: <001801cc6b8a$e953bda0$bbfb38e0$%kim@samsung.com>
References: <1314976702-19284-1-git-send-email-thomas.abraham@linaro.org>
	<1314976702-19284-2-git-send-email-thomas.abraham@linaro.org>
	<1314976702-19284-3-git-send-email-thomas.abraham@linaro.org>
	<001801cc6b8a$e953bda0$bbfb38e0$%kim@samsung.com>
Message-ID: <CAJuYYwT1tW0XEiwWWpX08OorZw2q2Wce2r0fUvxLmWC8uq6uhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Kim,

On 5 September 2011 10:46, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> The sdhci platform helper function that sets up the default controller
>> configuration is removed for all Samsung platforms since such default
>> controller configuration can be handled by the driver.
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?arch/arm/mach-exynos4/setup-sdhci.c ? ? ? ?| ? 47 -----------------------
>> ?arch/arm/mach-s3c2416/setup-sdhci.c ? ? ? ?| ? 37 ------------------
>> ?arch/arm/mach-s3c64xx/setup-sdhci.c ? ? ? ?| ? 48 -----------------------
>> ?arch/arm/mach-s5pc100/setup-sdhci.c ? ? ? ?| ? 42 --------------------
>> ?arch/arm/mach-s5pv210/setup-sdhci.c ? ? ? ?| ? 41 --------------------
>> ?arch/arm/plat-samsung/dev-hsmmc.c ? ? ? ? ?| ? ?2 -
>> ?arch/arm/plat-samsung/dev-hsmmc1.c ? ? ? ? | ? ?2 -
>> ?arch/arm/plat-samsung/dev-hsmmc2.c ? ? ? ? | ? ?2 -
>> ?arch/arm/plat-samsung/dev-hsmmc3.c ? ? ? ? | ? ?2 -
>> ?arch/arm/plat-samsung/include/plat/sdhci.h | ? 57
> ----------------------------
>> ?10 files changed, 0 insertions(+), 280 deletions(-)
>>

[...]

>
> Hi Thomas,
>
> The arch/arm/plat-samsung/dev-hsmmcX.c files have been changed due to commit
> 61e62fcb ("ARM: SAMSUNG: Consolidate common function to set SDHCI plat
> data"). So if possible please make your patch based on latest my for-next :)

Sure. I will base these patches on your for-next, test and resubmit.

Thanks,
Thomas.

>
> If any problems, please let me know.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>

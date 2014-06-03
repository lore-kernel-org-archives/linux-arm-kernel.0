From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 Jun 2014 11:11:15 -0700
Subject: [PATCH] ARM: Remove ARCH_HAS_CPUFREQ config option
In-Reply-To: <CAK5sBcEbLetRcgPuDJ30RqYjLOHhCXChtKE5ep22ZvEPWc9XwA@mail.gmail.com>
References: <1401746847-3193-1-git-send-email-sboyd@codeaurora.org>
 <CAK5sBcEbLetRcgPuDJ30RqYjLOHhCXChtKE5ep22ZvEPWc9XwA@mail.gmail.com>
Message-ID: <538E0FC3.8050904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/14 23:13, Sachin Kamat wrote:
> On Tue, Jun 3, 2014 at 3:37 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> @@ -831,7 +817,6 @@ config ARCH_S5PV210
>>
>>  config ARCH_EXYNOS
>>         bool "Samsung EXYNOS"
>> -       select ARCH_HAS_CPUFREQ
>>         select ARCH_HAS_HOLES_MEMORYMODEL
>>         select ARCH_REQUIRE_GPIOLIB
>>         select ARCH_SPARSEMEM_ENABLE
> I think this patch is not based on the latest code base as ARCH_EXYNOS
> symbol is now defined in arch/arm/mach-exynos/Kconfig file.

Hm.. yes. It was based on linux-next from the middle of May. I'll
regenerate it now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

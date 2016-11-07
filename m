From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Mon, 07 Nov 2016 09:07:42 +0530
Subject: [PATCH 1/4] ARM: EXYNOS: Remove smp_init_cpus hook from platsmp.c
In-Reply-To: <20161105154119.GA8183@kozik-lap>
References: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
 <1478230764-13748-2-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161105154127epcas1p1316e4c558b8442426db131ce7bb87bd2@epcas1p1.samsung.com>
 <20161105154119.GA8183@kozik-lap>
Message-ID: <581FF706.3050502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Saturday 05 November 2016 09:11 PM, Krzysztof Kozlowski wrote:
> On Fri, Nov 04, 2016 at 09:09:21AM +0530, Pankaj Dubey wrote:
>> We can safely remove exynos_smp_init_cpus() hook from mach-exynos/platsmp.c,
>> as all SMP platforms in mach-exynos can rely on DT for CPU core description
>> instead of determining number of cores from the SCU.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  arch/arm/mach-exynos/platsmp.c | 31 -------------------------------
>>  1 file changed, 31 deletions(-)
>>
> 
> 
> Thanks, applied. Somehow your patchset did not reach linux-samsung-soc's
> Parchwork. I don't have a clue why... It is on linux-arm-kernel's
> Patchwork.
> 

Thanks for looking into this series.

I am also not sure why its not reflecting for you on linux-samsung-soc's
Patchwork, but I can see this series in linux-samsung-soc Patchwork at
below links:

[1/4]: https://patchwork.kernel.org/patch/9411787/
[2/4]: https://patchwork.kernel.org/patch/9411789/
[3/4]: https://patchwork.kernel.org/patch/9411791/
[4/4]: https://patchwork.kernel.org/patch/9411793/

Will you please review other two patches (3/4 and 4/4) in this series?

Thanks,
Pankaj Dubey

> Best regards,
> Krzysztof
> 
> 
> 
> 

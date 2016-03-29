From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 29 Mar 2016 13:39:46 +0900
Subject: [PATCH 3/3] cpufreq: exynos: Use generic platdev driver
In-Reply-To: <20160329041923.GB25424@vireshk-i7>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <6cb29053bce7026dd9429326236a67c45e901c7b.1458801338.git.viresh.kumar@linaro.org>
 <56FA0039.6030007@samsung.com> <20160329041827.GA25424@vireshk-i7>
 <20160329041923.GB25424@vireshk-i7>
Message-ID: <56FA0712.6020802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.03.2016 13:19, Viresh Kumar wrote:
> On 29-03-16, 09:48, Viresh Kumar wrote:
>> On 29-03-16, 13:10, Krzysztof Kozlowski wrote:
>>> On 24.03.2016 15:40, Viresh Kumar wrote:
>>>> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
>>>> device now, reuse that and remove similar code from platform code.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>  arch/arm/mach-exynos/exynos.c        | 25 -------------------------
>>>>  drivers/cpufreq/cpufreq-dt-platdev.c |  5 +++++
>>>>  2 files changed, 5 insertions(+), 25 deletions(-)
>>>
>>> Looks fine to me... except that it is a little bit outdated. Please
>>> rebase on v4.6-rc1 because Bartlomiej added support for cpufreq @Exynos542x.
>>
>> Yeah, I know. I already have the updated version.
> 
> Here it is:
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Thu, 24 Mar 2016 12:04:10 +0530
> Subject: [PATCH] cpufreq: exynos: Use generic platdev driver
> 
> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> device now, reuse that and remove similar code from platform code.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-exynos/exynos.c        | 29 -----------------------------
>  drivers/cpufreq/cpufreq-dt-platdev.c |  9 +++++++++
>  2 files changed, 9 insertions(+), 29 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>



Best regards,

Krzysztof

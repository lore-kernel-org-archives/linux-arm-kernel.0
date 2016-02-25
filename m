From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 25 Feb 2016 09:13:31 +0900
Subject: [GIT PULL 2/7] ARM: dts: Exynos DT dependency for v4.6
In-Reply-To: <20160224222319.GU10126@localhost>
References: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
 <1455496446-23779-3-git-send-email-k.kozlowski@samsung.com>
 <20160224222319.GU10126@localhost>
Message-ID: <56CE472B.5020201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.02.2016 07:23, Olof Johansson wrote:
> On Mon, Feb 15, 2016 at 09:34:01AM +0900, Krzysztof Kozlowski wrote:
>> Hi Arnd, Kevin and Olof,
>>
>> Early DT changes for v4.6, needed before removal of SROM support
>> from mach-exynos.
>>
>> Kind regards,
>> Krzysztof
>>
>>
>> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
>>
>>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-srom-4.6
>>
>> for you to fetch changes up to d2deef6c61e65d1e0cee40c1d74fa99007da8c84:
>>
>>   ARM: dts: Add SROM to exynos5410 (2016-01-25 10:32:07 +0900)
>>
>> ----------------------------------------------------------------
>> Device Tree changes for v4.6 adding the nodes for Exynos SROM controller
>> driver. The driver saves and restores SROM registers during suspend to RAM.
>> DT changes should go in before removal of SROM support from mach-exynos.
>>
>> ----------------------------------------------------------------
>> Pankaj Dubey (2):
>>       ARM: dts: Add SROM device node for exynos4
>>       ARM: dts: Add SROM device node for exynos5
>>
>> Pavel Fedin (1):
>>       ARM: dts: Add SROM to exynos5410
> 
> Hi,
> 
> Please use the format:
> 
> ARM: dts: exynos: ...
> 
> in the future.

Sure! I was using it before... but switched to Kukjin's format.

Thanks for merging,
Krzysztof

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 06 Oct 2015 10:43:42 +0900
Subject: [GIT PULL] ARM: dts: Exynos improvements for 4.4
In-Reply-To: <175801d0ffd8$36b05910$a4110b30$@kernel.org>
References: <1443579766-15793-1-git-send-email-k.kozlowski@samsung.com>
 <1443579766-15793-2-git-send-email-k.kozlowski@samsung.com>
 <175801d0ffd8$36b05910$a4110b30$@kernel.org>
Message-ID: <5613274E.8020801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.10.2015 10:42, Kukjin Kim wrote:
> Krzysztof Kozlowski wrote:
>>
>> Dear Kukjin,
>>
> Hi,
> 
>> DTS related changes for 4.4.
>>
>> Description along with a tag.
>> You can find them also on the lists with my reviewed-by.
>>
> I have small comments. Then I could just pull your branch...
> 
>> Best regards,
>> Krzysztof
>>
>>
>> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
>>
>>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/krzk/linux.git tags/samsung-dt-4.4
>>
>> for you to fetch changes up to 01dd011b7a0230a426a79475ae452298421a16e4:
>>
>>   ARM: dts: exynos4412-trats2: remove regulator-compatible usage (2015-09-30 09:03:03 +0900)
>>
>> ----------------------------------------------------------------
>> Device Tree improvements for Exynos based boards:
>> 1. Enable DMA on Exynos4 serial ports. This old patch uncovered
>>    a number of other issues in dmaengine and samsung serial driver.
>>    All of known issues are resolved so finally enable the DMA for UART.
>> 2. Fix incorrect location of display-timings node (FIMD->DP node).
>> 3. Minor cleanups.
>>
>> ----------------------------------------------------------------
>> Javier Martinez Canillas (1):
>>       ARM: dts: exynos4412-trats2: remove regulator-compatible usage
> 
> Can you please move the dt name at the end of subject like others?

Ok

> 
>>
>> Robert Baldyga (1):
>>       ARM: dts: Add DMA support for serial ports in exynos4
>>
>> Sean Paul (1):
>>       ARM: dts: Move display-timings node from fimd to dp on Exynos
> 
> For all of exynos? If not, please specify the dt file in subject so that we
> could realize what has been updated.

Sure, I'll fix it and resend pull request.

Best regards,
Krzysztof


> 
>>
>> Tobias Jakobi (2):
>>       ARM: dts: Remove redundant pinctrl settings in exynos4412-odroid
>>       ARM: dts: Unify voltage regulator style in exynos4412-odroid
>>
>> Vladimir Zapolskiy (1):
>>       ARM: dts: Fix cpu compatible value for s3c2416
>>
>>  arch/arm/boot/dts/exynos4.dtsi                  |   8 ++
>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  12 +--
>>  arch/arm/boot/dts/exynos4412-trats2.dts         | 105 ++++++++----------------
>>  arch/arm/boot/dts/exynos5250-arndale.dts        |   8 +-
>>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |  16 ++--
>>  arch/arm/boot/dts/exynos5420-smdk5420.dts       |   7 +-
>>  arch/arm/boot/dts/s3c2416.dtsi                  |   2 +-
>>  7 files changed, 62 insertions(+), 96 deletions(-)
> 
> - Kukjin
> 
> 

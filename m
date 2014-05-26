From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 May 2014 07:08:21 +0900
Subject: [PATCH v11 0/3] Exynos 5410 support
In-Reply-To: <53832157.2020502@gmail.com>
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
 <53832157.2020502@gmail.com>
Message-ID: <5383BB55.9070606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/14 20:11, Tomasz Figa wrote:
> Hi,
>
Hi

> On 26.05.2014 05:23, Tarek Dakhran wrote:
>> The series of patches represent support of Exynos 5410 SoC
>>
>> The Exynos 5410 is the first Samsung SoC based on big.LITTLE architecture
>>
>> Patches add new platform description, support of clock controller and device
>> tree for Exynos 5410.
>>
>> Has been build on Samsung Linux Kernel
>>    (branch: for-next, commit: 97eae6c Merge branch 'v3.16-next/multiplatform' into for-next)
>>
>> Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
>> 		    2) Exynos 5410 reference board (multi_v7_defconfig)
>> 		    3) Odroid-XU board (exynos_defconfig)
>> 		    4) Odroid-XU board (multi_v7_defconfig)
>>
Thanks for your test with exynos_defconfig and multi_v7_defconfig.

>> I hope this is clean and would be applied.
>>
>> Tarek.
>>
>> Tarek Dakhran (3):
>>    ARM: EXYNOS: Add support for EXYNOS5410 SoC
>>    clk: exynos5410: register clocks using common clock framework
>>    ARM: dts: Add initial device tree support for EXYNOS5410
>>
>>   .../devicetree/bindings/clock/exynos5410-clock.txt |   45 +++++
>>   arch/arm/boot/dts/Makefile                         |    1 +
>>   arch/arm/boot/dts/exynos5410-smdk5410.dts          |   82 ++++++++
>>   arch/arm/boot/dts/exynos5410.dtsi                  |  206 +++++++++++++++++++
>>   arch/arm/mach-exynos/Kconfig                       |    5 +
>>   arch/arm/mach-exynos/common.h                      |   12 +-
>>   drivers/clk/samsung/Makefile                       |    1 +
>>   drivers/clk/samsung/clk-exynos5410.c               |  209 ++++++++++++++++++++
>>   include/dt-bindings/clock/exynos5410.h             |   33 ++++
>>   9 files changed, 592 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
>>   create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
>>   create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
>>   create mode 100644 drivers/clk/samsung/clk-exynos5410.c
>>   create mode 100644 include/dt-bindings/clock/exynos5410.h
>>
>
> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
>
Applied this whole series.

Thanks,
Kukjin

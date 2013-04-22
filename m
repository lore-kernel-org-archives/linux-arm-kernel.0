From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 22 Apr 2013 16:50:39 +0530
Subject: [PATCH 0/2] ARM: Exynos: Add DT based I/O mapping for Chip-ID
 controller
In-Reply-To: <27ea01ce3101$a8dae850$fa90b8f0$%kim@samsung.com>
References: <1361174099-18749-1-git-send-email-thomas.abraham@linaro.org>
 <27ea01ce3101$a8dae850$fa90b8f0$%kim@samsung.com>
Message-ID: <CAJuYYwTV5U8-wqNhet4ZEdgRSnbok6-ziE-qkx4ee9j84z8xdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2013 12:27, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> This patch series allows device tree enabled platforms to setup a runtime
>> I/O mapping for the chip-id controller. This helps to remove statically
>> defined I/O mapping for the Chip-ID controller.
>>
>> Thomas Abraham (2):
>>   ARM: Exynos: Create virtual I/O mapping for Chip-ID controller using
>> device tree
>>   ARM: dts: Add chip-id controller node on Exynos4/5 SoC
>>
>>  .../arm/samsung/samsung,exynos4210-chipid.txt      |   15 ++++++
>>  arch/arm/boot/dts/exynos4.dtsi                     |    5 ++
>>  arch/arm/boot/dts/exynos5250.dtsi                  |    5 ++
>>  arch/arm/mach-exynos/common.c                      |   53
> +++++++++++---------
>>  arch/arm/mach-exynos/include/mach/map.h            |    1 -
>>  5 files changed, 55 insertions(+), 24 deletions(-)
>>  create mode 100644
>> Documentation/devicetree/bindings/arm/samsung/samsung,exynos4210-
>> chipid.txt
>>
>> --
>> 1.7.5.4
>
> Thomas,
>
> Can you update this series can support exynos5440 as well? It should be done
> together.

Hi Mr. Kim,

Sorry for the delayed reply. This patch series is supported for
Exynos5440 as well. The v2 version of this patch series has been
submitted.

Thanks,
Thomas.

>
> - Kukjin
>

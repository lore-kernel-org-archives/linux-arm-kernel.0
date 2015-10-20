From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 20 Oct 2015 14:26:39 +0530
Subject: [PATCH 0/7] Switch to generic syscon regmap based drivers
In-Reply-To: <CAAtXAHfjdNvJtXW6e4Wm4dba9vbzhpMGJvTBXxvmya08EvHenA@mail.gmail.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <CAAtXAHfjdNvJtXW6e4Wm4dba9vbzhpMGJvTBXxvmya08EvHenA@mail.gmail.com>
Message-ID: <562601C7.8070705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

On 10/20/2015 02:48 AM, Moritz Fischer wrote:
> On Sun, Oct 18, 2015 at 11:03 PM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
>> Alim Akhtar (7):
>>    arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
>>    arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
>>    arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
>>    arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
>>    ARM: exynos_defconfig: Normalize exynos defconfig
>>    ARM: exynos_defconfig: Enable generic syscon-{reboot, poweroff}
>>      drivers
>>    ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs
>>
>>   arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
>>   arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
>>   arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
>>   arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
>>   arch/arm/configs/exynos_defconfig |   11 +++++-----
>>   arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
>>   6 files changed, 61 insertions(+), 49 deletions(-)
>>
>> --
>> 1.7.10.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Feel free to add Acked-By: Moritz Fischer <moritz.fischer@ettus.com>
> to the patches in your series
>
Thanks!
> Moritz
>

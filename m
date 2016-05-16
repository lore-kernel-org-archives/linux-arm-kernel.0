From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 16 May 2016 20:17:45 +0200
Subject: [PATCH-V2 5/5] ARM: multi_v7_defconfig: bcm2835: add
 bcm2835-thermal driver
In-Reply-To: <5739F8AC.8080003@gmail.com>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
 <1463145186-12906-6-git-send-email-kernel@martin.sperl.org>
 <5739F8AC.8080003@gmail.com>
Message-ID: <40E50EF4-240B-4E40-8344-1F9042EC1473@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 16.05.2016, at 18:43, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> On 05/13/2016 06:13 AM, kernel at martin.sperl.org wrote:
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Add the thermal driver to list of compiled modules in
>> multi_v7_defconfig.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>> arch/arm/configs/multi_v7_defconfig | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 2823490..5f0f5a3 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -422,6 +422,7 @@ CONFIG_CPU_THERMAL=y
>> CONFIG_ROCKCHIP_THERMAL=y
>> CONFIG_RCAR_THERMAL=y
>> CONFIG_ARMADA_THERMAL=y
>> +CONFIG_BCM2835_THERMAL=y
> 
> Does this need to be built into the kernel?
> 
Not necessarily, but as most other drivers in this context
are built in this one was added as such as well.

If the policy is different, then I can change it...

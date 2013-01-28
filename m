From: monstr@monstr.eu (Michal Simek)
Date: Mon, 28 Jan 2013 15:28:51 +0100
Subject: [PATCH] arm: zynq: Add missing irqchip.h to common.c
In-Reply-To: <51068861.8060309@gmail.com>
References: <1359376250-18841-1-git-send-email-michal.simek@xilinx.com>
 <51068861.8060309@gmail.com>
Message-ID: <CAHTX3dL5yzM9br-jvh7-dMtHKjD-sT75qmQw52oi_8VCAZsxyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

2013/1/28 Rob Herring <robherring2@gmail.com>:
> On 01/28/2013 06:30 AM, Michal Simek wrote:
>> The patch: "ARM: use common irqchip_init for GIC init"
>> (sha1: 0529e315bbda5d502c93df2cfafba9bb337fbdf4)
>> should also add linux/irqchip.h header.
>>
>> Error message:
>> arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init'
>>   undeclared here (not in a function)
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>
> FYI, there's already a patch posted for this:
>
> http://www.spinics.net/lists/arm-kernel/msg219556.html

Interesting that I am completely ignored in CC.
Anyway updated maintainer fragment hopefully resolve this.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform

From: monstr@monstr.eu (Michal Simek)
Date: Mon, 27 May 2013 16:05:17 +0200
Subject: [GIT PULL] arm-soc: Xilinx zynq core - smp for v3.10
In-Reply-To: <20130524112610.GX18614@n2100.arm.linux.org.uk>
References: <890ef3b8-f536-4b00-9bd8-5ea50de3bf51@DB8EHSMHS032.ehs.local>
 <20130524112610.GX18614@n2100.arm.linux.org.uk>
Message-ID: <51A3681D.1000107@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 05/24/2013 01:26 PM, Russell King - ARM Linux wrote:
> On Thu, Apr 04, 2013 at 09:47:09AM +0200, Michal Simek wrote:
>> Hi Arnd and Olof,
>>
>> please pull the following smp support to your arm-soc tree.
>>
>> This branch is based on zynq/clksrc/cleanup parts because
>> there are some dependencies on moving timer to generic location.
>>
>> I could based it on standard Linux tagged version but you will get
>> several conflicts you will have to resolve.
>> If you are OK to resolving these problems, please let me know
>> I will create another branch with core-smp changes which are not based
>> on zynq/clksrc/cleanup branch.
> 
> You might want to resolve this new warning:
> 
> arch/arm/mach-zynq/hotplug.c:1:0: warning: switch -mcpu=cortex-a9 conflicts with -march= switch
> 
> found by lastnights OMAP4430 randconfig build.

I have looked at it. (I downloaded .config last week to have).
I have tried gcc 4.6.3 from kernel.org
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/
and also (Sourcery CodeBench Lite 2011.09-50) 4.6.1 toolchain
but I can't see this warning.

Which gcc version do you use?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130527/5db8176c/attachment-0001.sig>

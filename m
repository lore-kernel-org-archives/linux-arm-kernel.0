From: monstr@monstr.eu (Michal Simek)
Date: Fri, 24 May 2013 14:37:24 +0200
Subject: [GIT PULL] arm-soc: Xilinx zynq core - smp for v3.10
In-Reply-To: <20130524123132.GA13111@n2100.arm.linux.org.uk>
References: <890ef3b8-f536-4b00-9bd8-5ea50de3bf51@DB8EHSMHS032.ehs.local>
 <20130524112610.GX18614@n2100.arm.linux.org.uk>
 <744356bb-78fa-4592-97ef-0709fe65dbee@CH1EHSMHS025.ehs.local>
 <20130524123105.GZ18614@n2100.arm.linux.org.uk>
 <20130524123132.GA13111@n2100.arm.linux.org.uk>
Message-ID: <519F5F04.3030400@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2013 02:31 PM, Russell King - ARM Linux wrote:
> On Fri, May 24, 2013 at 01:31:05PM +0100, Russell King - ARM Linux wrote:
>> On Fri, May 24, 2013 at 02:10:32PM +0200, Michal Simek wrote:
>>> Hi Russell,
>>>
>>> On 05/24/2013 01:26 PM, Russell King - ARM Linux wrote:
>>>> You might want to resolve this new warning:
>>>>
>>>> arch/arm/mach-zynq/hotplug.c:1:0: warning: switch -mcpu=cortex-a9 conflicts with -march= switch
>>>>
>>>> found by lastnights OMAP4430 randconfig build.
>>>
>>> Do you have that randconfig file?
>>> And can you please point me to the repo which is is used for this build?
>>
>> Everything which is public is at:
>>
>> http://www.home.arm.linux.org.uk/developer/build/
> 
> Err, drop the .home bit out of that.

Thanks that's everything what I need.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130524/60daf3ee/attachment.sig>

From: monstr@monstr.eu (Michal Simek)
Date: Fri, 21 Aug 2015 08:36:09 +0200
Subject: [GIT PULL] Xilinx Zynq DT changes for v4.3 v2
In-Reply-To: <20150821020322.GO4865@localhost>
References: <55D4646F.7010404@monstr.eu> <20150821020322.GO4865@localhost>
Message-ID: <55D6C6D9.3070401@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2015 04:03 AM, Olof Johansson wrote:
> On Wed, Aug 19, 2015 at 01:11:43PM +0200, Michal Simek wrote:
>> Hi guys,
>>
>> Philipp just sent his PR to you with adding reset controller for Zynq
>> (http://www.spinics.net/lists/arm-kernel/msg440136.html).
>> Can you please consider to add this one more patch to your tree?
>> It is one more patch on the top of existing zynq/dt branch which you
>> already have in arm-soc git repo.
> 
> The change is small enough, so yes we can merge it with the below fixed:
> 
>> Moritz Fischer (1):
>>       dts: zynq: Add devicetree entry for Xilinx Zynq reset controller.
> 
> ARM: dts: <....> is the format we want here -- that's what most other platforms
> use as well. I.e. please add ARM as a prefix.

ok. Will keep my eye on it.

> 
> I can do it here and just apply as a patch too instead of merging, just let me
> know.

Yes that will be great if you can do that change on your side.

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
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150821/9673bbc0/attachment.sig>

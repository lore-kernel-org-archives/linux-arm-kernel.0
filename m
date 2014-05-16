From: monstr@monstr.eu (Michal Simek)
Date: Fri, 16 May 2014 14:54:58 +0200
Subject: [PATCH] ARM: zynq: dt: Add a fixed regulator for CPU voltage
In-Reply-To: <e9675d40-2fd9-4fed-a020-5b465ea1842d@BN1BFFO11FD047.protection.gbl>
References: <1399064852-19569-1-git-send-email-soren.brinkmann@xilinx.com>
 <e9675d40-2fd9-4fed-a020-5b465ea1842d@BN1BFFO11FD047.protection.gbl>
Message-ID: <53760AA2.4040703@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2014 04:57 PM, S?ren Brinkmann wrote:
> ping? Any comments?
> 
> 	Thanks,
> 	S?ren
> 
> On Fri, 2014-05-02 at 02:07PM -0700, Soren Brinkmann wrote:
>> To silence the warning
>> 	cpufreq_cpu0: failed to get cpu0 regulator: -19
>> from the cpufreq driver regarding a missing regulator,
>> add a fixed regulator to the DT.
>> Zynq does not support voltage scaling and the CPU rail should always be
>> supplied with 1 V, hence it is added in the SOC-level dtsi.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>>
>>  arch/arm/boot/dts/zynq-7000.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)

Probably no objection from others.
Applied to zynq/dt branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/4b47294a/attachment-0001.sig>

From: monstr@monstr.eu (Michal Simek)
Date: Thu, 12 Dec 2013 20:07:09 +0100
Subject: [PATCH v2 1/9] arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
In-Reply-To: <552285d2-8d57-4509-a014-d97065232376@DB8EHSMHS004.ehs.local>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-2-git-send-email-soren.brinkmann@xilinx.com>
 <52A97979.1030205@monstr.eu>
 <552285d2-8d57-4509-a014-d97065232376@DB8EHSMHS004.ehs.local>
Message-ID: <52AA095D.4020707@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 06:01 PM, S?ren Brinkmann wrote:
> Hi Michal,
> 
> On Thu, Dec 12, 2013 at 09:53:13AM +0100, Michal Simek wrote:
>> On 11/27/2013 02:04 AM, Soren Brinkmann wrote:
>>> The bindings for the TTC changed in commit 'arm: zynq: Use standard
>>> timer binding' (e932900a3279b5dbb6d8f43c7b369003620e137c). That change
>>> removed possible subnodes from this driver rendering the 'clock-ranges'
>>> property invalid for this node.
>>>
>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/zynq-7000.dtsi | 2 --
>>>  1 file changed, 2 deletions(-)
>>
>> I think this is completely unrelated to cpufreq and should just go
>> directly via arm-soc tree.
>> If yes, I will add 1/9 and 2/9 to zynq/dt branch.
> 
> I agree. This is just clean up that I found during this work. The second
> patch could go in as well I think. cpufreq will need the CPU nodes
> later, but I think there is no real reason to not add them now.

ok then. 1/9 and 2/9 applied to zynq/dt branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/ce8f31d6/attachment.sig>

From: monstr@monstr.eu (Michal Simek)
Date: Thu, 8 Dec 2016 12:43:28 +0100
Subject: [GIT PULL] ARM: Xilinx Zynq SOC changes for v4.10
In-Reply-To: <20161207203629.GD10158@localhost>
References: <1ff060ae-b142-9e72-6fef-21b81a147614@monstr.eu>
 <20161207203629.GD10158@localhost>
Message-ID: <efa6ff0c-26e2-feaa-e069-94df908a1bd9@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7.12.2016 21:36, Olof Johansson wrote:
> On Tue, Dec 06, 2016 at 01:46:01PM +0100, Michal Simek wrote:
>> Hi,
>>
>> please pull this fix to your tree.
>>
>> Thanks,
>> Michal
>>
>>
>> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
>>
>>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.10
>>
>> for you to fetch changes up to 7a3cc2a7b2c723aa552028f4e66841cec183756d:
>>
>>   ARM: zynq: Reserve correct amount of non-DMA RAM (2016-11-14 16:07:58
>> +0100)
>>
>> ----------------------------------------------------------------
>> arm: Xilinx Zynq patches for v4.10
>>
>> - Fix dma issue
>>
>> ----------------------------------------------------------------
>> Kyle Roeschley (1):
>>       ARM: zynq: Reserve correct amount of non-DMA RAM
> 
> Merged, thanks.  Should this have been a fix, btw? I queued it for 4.10 merge
> window now.

yes it is also fix and should go to stable but it is not marked like
that why queue to 4.10 should be fine.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161208/dce0d59b/attachment.sig>

From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jul 2014 10:08:06 +0200
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <53D20A61.1050506@metafoo.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-10-git-send-email-afaerber@suse.de>
 <53D20A61.1050506@metafoo.de>
Message-ID: <53D21066.8000905@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 07/25/2014 09:42 AM, Lars-Peter Clausen wrote:
> On 07/25/2014 01:00 AM, Andreas F?rber wrote:
>> The specification requires compatible = "adi,axi-spdif-1.00.a" but
>> driver and example and file name indicate "adi,axi-spdif-tx-1.00.a".
>> Change the specification to match the implementation.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

All these patches have been added through your tree that's why I think
you should take this fix through his tree.

Here is my:
Reviewed-by: Michal Simek <michal.simek@xilinx.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/3f7f6506/attachment.sig>

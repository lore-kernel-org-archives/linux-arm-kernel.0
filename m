From: monstr@monstr.eu (Michal Simek)
Date: Tue, 29 Jul 2014 07:33:20 +0200
Subject: [LINUX PATCH] ARM: zynq: DT: Remove DMA from board DTs
In-Reply-To: <53D67B3C.3050401@suse.de>
References: <1406564643-10417-1-git-send-email-soren.brinkmann@xilinx.com>
 <53D67B3C.3050401@suse.de>
Message-ID: <53D73220.8040704@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2014 06:33 PM, Andreas F?rber wrote:
> Am 28.07.2014 18:24, schrieb Soren Brinkmann:
>> The DMA engine is enabled for all DTs that derive from zynq-7000.dtsi.
>> There is no need to override the 'status' property in board DTs.
>>
>> Cc: Andreas F?rber <afaerber@suse.de>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>> When the 'status' property was removed from the DMA node, this had been
>> overlooked.
> 
> Indeed,
> 
> Reviewed-by: Andreas F?rber <afaerber@suse.de>

Applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/d5d4c229/attachment.sig>

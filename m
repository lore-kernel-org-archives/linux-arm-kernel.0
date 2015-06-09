From: monstr@monstr.eu (Michal Simek)
Date: Tue, 09 Jun 2015 08:03:19 +0200
Subject: [PATCH v4 2/2] dma: Add Xilinx AXI Central Direct Memory Access
 Engine driver support
In-Reply-To: <1432290653.27695.97.camel@x220>
References: <1432228035-6569-1-git-send-email-appanad@xilinx.com>
 <1432290653.27695.97.camel@x220>
Message-ID: <557681A7.7080202@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 05/22/2015 12:30 PM, Paul Bolle wrote:
> Again, just a nit: a license mismatch.
> 
> On Thu, 2015-05-21 at 22:37 +0530, Kedareswara rao Appana wrote:
> 
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
> 
>> +MODULE_LICENSE("GPL v2");
> 
> As I said in the message I sent a short while ago: here too I think that
> either the comment at the top of this file or the ident used in the
> MODULE_LICENSE() macro needs to change.

This is not just the problem with this driver but with others too.
Have you sent any patch to add GPL v2+ to license.h?

Also sort of checking for this will be great. Julia?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/b41a6602/attachment-0001.sig>

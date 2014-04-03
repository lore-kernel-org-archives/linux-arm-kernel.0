From: monstr@monstr.eu (Michal Simek)
Date: Thu, 03 Apr 2014 16:55:46 +0200
Subject: [PATCH 00/75] l2c series
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <533D7672.4090003@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 03/28/2014 04:12 PM, Russell King - ARM Linux wrote:
> This is another posting of the L2 cache controller series.  I'm not
> planning for this for the upcoming merge window, but the one after,
> as people need to test it and still need to feed back to me on
> various issues.  Hence, this is not a finalised series.
> 
> There are still various issues which I've raised, and have had no
> feedback on.
> 
> This series is being posted with Cc's on the individual patches.

I just want to also point you that we have sent EDAC support for pl310
which will be good to have it for L2.
[RFC PATCH] EDAC support for ARM PL310 cache controller
[RFC PATCH] edac: add support for ARM PL310 L2 cache parity
http://lkml.org/lkml/2014/3/2/85
http://lkml.org/lkml/2014/3/2/87

None has reviewed it yet but will be good to add it when you do
this huge L2 cleanup.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/bcd5ee5b/attachment.sig>

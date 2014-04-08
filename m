From: monstr@monstr.eu (Michal Simek)
Date: Tue, 08 Apr 2014 10:33:19 +0200
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <20140407065651.GA2609@katana>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de> <5342481B.6020600@monstr.eu>
 <20140407065651.GA2609@katana>
Message-ID: <5343B44F.2070407@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 08:56 AM, Wolfram Sang wrote:
> 
>> I would suggest to add relaxed IO helper function to asm-generic/io.h
>> to be available for all archs. Then we can avoid this type of errors.
> 
> I favour this, too. For the cadence driver, I needed a quick solution
> before linux-next breaks, though.
> 

FYI: Here is the patch
http://www.spinics.net/lists/kernel/msg1718606.html

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/19ac1649/attachment.sig>

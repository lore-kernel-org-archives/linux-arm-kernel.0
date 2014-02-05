From: monstr@monstr.eu (Michal Simek)
Date: Wed, 05 Feb 2014 10:41:06 +0100
Subject: [PATCH 09/10] watchdog: xilinx: Add missing binding
In-Reply-To: <201402051036.19428.arnd@arndb.de>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <201402042027.15898.arnd@arndb.de> <52F20387.3090709@monstr.eu>
 <201402051036.19428.arnd@arndb.de>
Message-ID: <52F20732.6070209@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2014 10:36 AM, Arnd Bergmann wrote:
> On Wednesday 05 February 2014, Michal Simek wrote:
>> I am not quite sure what you mean by reports to user space.
>> If you mean to get timeout through ioctl for example - then yes it is working
>> through standard watchdog ioctl interface and timeout is calculated
>> from hardware setup.
> 
> Yes, that is what I meant. I believe most other watchdogs let
> you program the timeout, but I don't see anything wrong with
> having that fixed in the FPGA in your case.
> 
> Still, the choice of putting the timeout into DT in terms of
> cycles rather than miliseconds wasn't ideal from an interface
> perspective and we should change that if/when we do a generic
> binding. I can definitely see where it's coming from for your
> case, as the cycle count totally makes sense from an FPGA
> tool perspective...

Thanks. I take this like ACK for this current binding description.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/a5adb1d4/attachment-0001.sig>

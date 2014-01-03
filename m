From: monstr@monstr.eu (Michal Simek)
Date: Fri, 03 Jan 2014 14:34:18 +0100
Subject: [PATCH 1/2] zynq: Do not explicitely enable icache
In-Reply-To: <201401031352.51392.arnd@arndb.de>
References: <521bc636ed31ff2958f8c95417b09036a523782c.1388742126.git.michal.simek@xilinx.com>
 <201401031352.51392.arnd@arndb.de>
Message-ID: <52C6BC5A.9060203@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2014 01:52 PM, Arnd Bergmann wrote:
> On Friday 03 January 2014, Michal Simek wrote:
>> icache is already enabled by default.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  board/xilinx/zynq/board.c | 2 --
>>  1 file changed, 2 deletions(-)
> 
> You had me confused for a bit. Please mark u-boot patches as such
> when you send them to the kernel mailing list, and vice-versa.

oou. Patman (tools I use for sending patches to mailing list)
took arm prefix because of my bad setting.

Sorry for that.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/62504f87/attachment.sig>

From: monstr@monstr.eu (Michal Simek)
Date: Thu, 20 Jun 2013 07:23:28 +0200
Subject: [PATCH RFC 0/2] Extend multi_v7_defconfig
In-Reply-To: <201306192046.41005.arnd@arndb.de>
References: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
 <201306192046.41005.arnd@arndb.de>
Message-ID: <51C291D0.6000401@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2013 08:46 PM, Arnd Bergmann wrote:
> On Wednesday 19 June 2013, Soren Brinkmann wrote:
>> I don't know how much a defconfig is supposed to provide, hence as RFC.
>> This patches are needed for booting Zynq into a minimum ramfs based
>> system with a serial console.
> 
> In my opinion we should provide enable all the platform specific drivers
> in the defconfigs, as well as everything needed to boot the system,
> to get proper compile coverage as well as the ability to test changes
> easily. Your patches look good. Michal, would you apply them and
> send another pull request or should I just take them directly?

Soren asked me 2 days ago if make sense to create zynq defconfig or not.
I just suggested him to better extend this multi_v7_defconfig.
But still question is if we can/should create zynq specific defconfig?
Or are you going to remove all of these platform specific defconfig?

Definitely agree that multi_v7 defconfig should enable everything needed
to boot the system.
Does it also mean that we should also enable all zynq drivers
to get better compile coverage?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/dcdbdb1c/attachment.sig>

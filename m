From: monstr@monstr.eu (Michal Simek)
Date: Fri, 26 Sep 2014 08:03:13 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v3.18
In-Reply-To: <201409251746.14540.arnd@arndb.de>
References: <541819FD.5000301@monstr.eu> <201409251746.14540.arnd@arndb.de>
Message-ID: <542501A1.8020807@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/25/2014 05:46 PM, Arnd Bergmann wrote:
> On Tuesday 16 September 2014, Michal Simek wrote:
>>   git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.18
>>
>> for you to fetch changes up to 8097171e19bb69f3e2226827440b71ececa5d74f:
>>
>>   ARM: zynq: Remove useless L2C AUX setting (2014-09-16 12:55:12 +0200)
>>
>> ----------------------------------------------------------------
>> arm: Xilinx Zynq cleanup patches for v3.18
>>
>> - PM support
>> - Fix L2 useless setting
> 
> I don't see why this counts as cleanup when you add so much more code
> than you remove, but the individual changes all make sense, so I've
> pulled it into next/soc.

What's the branch name for adding new stuff? I see people are using soc.

> 
> Sorry for the delay.

No problem.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/2d10ab74/attachment.sig>

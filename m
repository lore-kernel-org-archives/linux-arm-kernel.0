From: monstr@monstr.eu (Michal Simek)
Date: Tue, 13 Jan 2015 19:44:40 +0100
Subject: [GIT PULL] Xilinx Zynq dt fixes for v3.19
In-Reply-To: <20150112220057.GA22090@quad.lixom.net>
References: <544519A4.5090003@monstr.eu> <54AE44AF.6010808@monstr.eu>
 <20150112220057.GA22090@quad.lixom.net>
Message-ID: <54B56798.6070001@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2015 11:00 PM, Olof Johansson wrote:
> On Thu, Jan 08, 2015 at 09:49:51AM +0100, Michal Simek wrote:
>> Hi,
>>
>> please consider to pull this one DT patch to your tree as fix for v3.19
>> It is adding USD dt node. Driver has been added to v3.19.
>>
>> Thanks,
>> Michal
>>
>> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>>
>>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>>
>> are available in the git repository at:
>>
>>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-fixes-for-3.19
>>
>> for you to fetch changes up to 1643b31658c44767a85469733c6bff4f6d0371c7:
>>
>>   ARM: zynq: DT: Add USB to device tree (2015-01-08 09:35:04 +0100)
> 
> Michal,
> 
> This isn't really a fix for something that is broken, is it? I.e. looks like
> new hardware support to me, and unfortunately this time in the release is wrong
> for that.
> 
> I'd be happy to queue it up for 3.20 though, so please confirm.

No problem to queue it up for 3.20. I will add some more patches on the top of this branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/7136bee9/attachment.sig>

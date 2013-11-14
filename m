From: monstr@monstr.eu (Michal Simek)
Date: Thu, 14 Nov 2013 10:39:49 +0100
Subject: [PATCH 00/11] Consolidate asm/fixmap.h files
In-Reply-To: <1384271711.24631.5.camel@deneb.redhat.com>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <52824BBC.9020401@monstr.eu> <1384271711.24631.5.camel@deneb.redhat.com>
Message-ID: <52849A65.9030500@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 04:55 PM, Mark Salter wrote:
> On Tue, 2013-11-12 at 16:39 +0100, Michal Simek wrote:
>> On 11/12/2013 02:22 PM, Mark Salter wrote:
>>>
>>>  arch/arm/include/asm/fixmap.h        |  25 ++------
>>>  arch/hexagon/include/asm/fixmap.h    |  40 +------------
>>>  arch/metag/include/asm/fixmap.h      |  32 +----------
>>>  arch/microblaze/include/asm/fixmap.h |  44 +-------------
>>>  arch/mips/include/asm/fixmap.h       |  33 +----------
>>>  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
>>>  arch/sh/include/asm/fixmap.h         |  39 +------------
>>>  arch/tile/include/asm/fixmap.h       |  33 +----------
>>>  arch/um/include/asm/fixmap.h         |  40 +------------
>>>  arch/x86/include/asm/fixmap.h        |  59 +------------------
>>>  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++++++++++
>>>  11 files changed, 125 insertions(+), 371 deletions(-)
>>>  create mode 100644 include/asm-generic/fixmap.h
>>
>> Any repo/branch with all these patches will be helpful.
> 
> https://github.com/mosalter/linux (fixmap branch)

Thanks,

For Microblaze
Tested-by: Michal Simek <monstr@monstr.eu>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/0d24ff52/attachment.sig>

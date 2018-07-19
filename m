From: monstr@monstr.eu (Michal Simek)
Date: Thu, 19 Jul 2018 09:53:44 +0200
Subject: [GIT PULL] arm64: zynqmp: Xilinx DT changes for v4.19
In-Reply-To: <CAOesGMhaVNmmsJStL8RXv_RP_yd7TSDdfTRUvnz+jx+7OY_O3A@mail.gmail.com>
References: <a0dc4c86-7fe6-b9f6-2d57-b418061dbb3c@monstr.eu>
 <CAOesGMhaVNmmsJStL8RXv_RP_yd7TSDdfTRUvnz+jx+7OY_O3A@mail.gmail.com>
Message-ID: <81309c16-211e-9d52-0241-1fa74bab3a56@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.7.2018 17:00, Olof Johansson wrote:
> On Wed, Jul 18, 2018 at 7:14 AM, Michal Simek <monstr@monstr.eu> wrote:
>> Hi,
>>
>> please pull the following arm64 DT patches.
>>
>> Thanks,
>> Michal
>>
>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>
>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>
>> are available in the git repository at:
>>
>>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-v4.19
>>
>> for you to fetch changes up to d287de28641beb953f7ab2bd6966b166ea5c6e99:
>>
>>   arm64: zynqmp: Add support for Avnet Ultra96 rev1 board (2018-07-17
>> 16:41:09 +0200)
>>
>> ----------------------------------------------------------------
>> arm: zynqmp: DT changes for v4.19
>>
>> - Use serdev for BT in zcu100
>> - Remove ep108
>> - Fix gpio-keys binding
>> - Add suport for Ultra96
>>
>> ----------------------------------------------------------------
>> Michal Simek (4):
>>       arm64: zynqmp: Use serdev for zcu100 BT
>>       arm64: zynqmp: Remove ep108 board
>>       arm64: zynqmp: Remove #address/#size-cells from gpio-keys
>>       arm64: zynqmp: Add support for Avnet Ultra96 rev1 board
> 
> Common style here is:
> 
> arm64: dts: zyncmp: <...>
> 
> Again, please respin and fix. We've been pretty lenient on this but
> it's turning into the wild west. :)

As you see above at least I am trying to be consistent with my patches.
Anyway fixed in v2.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/030fa335/attachment-0001.sig>

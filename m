From: monstr@monstr.eu (Michal Simek)
Date: Thu, 24 Aug 2017 15:35:14 +0200
Subject: [GIT PULL] ARM64: Xilinx ZynqMP DT fixes for v4.14
In-Reply-To: <CAK8P3a3nuxdtrcWFa28U8nF4k00v0VXWvDZr9hBzAioxsKV73Q@mail.gmail.com>
References: <36ea049b-a57f-78e5-440f-ab6cdf1df1f7@monstr.eu>
 <CAK8P3a3nuxdtrcWFa28U8nF4k00v0VXWvDZr9hBzAioxsKV73Q@mail.gmail.com>
Message-ID: <29721568-83f0-4c34-dc57-dbbe92544147@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.8.2017 17:43, Arnd Bergmann wrote:
> On Mon, Aug 21, 2017 at 2:14 PM, Michal Simek <monstr@monstr.eu> wrote:
>>
>>> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>>>
>>>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.14
>>>
>>> for you to fetch changes up to 0bb6f25a6ee5ff0826d2e620cbb78b1579c3d2ee:
>>>
>>>   arm64: zynqmp: Add generic compatible string for I2C EEPROM (2017-08-21 14:07:37 +0200)
>>>
>>> ----------------------------------------------------------------
>>> arm: Xilinx ZynqMP DT fixes for v4.14
>>>
>>> - Fix DTC warnings
>>> - Add idle states, OP, cci-400, RTC, pcie prefetchable memory
>>>   fpd/lpd dmas, clocks for ep108
>>> - Enable can1
>>> - Fix smmu IRQ, aliases, uart compatible string
>>> - Use generic compatible string for i2c eeprom
> 
> Pulled into next/dt64, thanks!
> 
> Some of these look like they might be needed on older kernels as well,
> but you only asked for these to be in 4.14, not 4.13 or older. Can you
> double-check if we should have some of them backported?

We are using them even on 4.9 but it doesn't matter. Going to v4.14 is fine.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/e3eb1379/attachment.sig>

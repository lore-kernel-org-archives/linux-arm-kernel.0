From: monstr@monstr.eu (Michal Simek)
Date: Tue, 11 Mar 2014 11:46:43 +0100
Subject: [PATCH v2 0/7] tty: xuartps: Rebranding + DT documentation
In-Reply-To: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <531EE993.80400@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2014 10:40 PM, Soren Brinkmann wrote:
> Hi,
> 
> this series rebrands the Xilinx PS UART driver as Cadence UART and
> documents its DT bindings (+ some clean up along the way).
> 
> The rebranding goes as far as reasonable. Things like file name, kconfig
> symbols and other things with user space impact are left as is. Please
> refer to the discussion in the RFC threads[1-2] for more details.
> 
> Similar the DT binding has been extended. In addition to the new and
> preferred Cadence binding, the current xuartps binding is maintained.
> Though, only the Cadence names for clock-names are documented.
> 
> References:
>  [1]  https://lkml.org/lkml/2014/3/4/405
>  [2]  https://lkml.org/lkml/2014/3/7/450
> 
> v2:
>  - no changes regarding the patches
>  - fixed (I sincerely hope) email recipients
> 
> Changes from the latest RFC:
>  - squashed function/symbol renaming into 'tty: xuartps: Rebrand driver
>    as Cadence UART'
>  - Revised the commit message of 'tty: xuartps: Don't write IRQ disable
>    register to enable interrupts' (was 'tty: xuartps: Remove bogus
>    comment and register write'

One more thing. I was thinking this is based on my 3 patches I have
already sent to mainline. But as I see they are not applied yet.

https://lkml.org/lkml/2014/1/21/107
https://lkml.org/lkml/2014/1/21/101
http://www.spinics.net/lists/arm-kernel/msg302796.html

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/39360ad4/attachment.sig>

From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 17 Apr 2014 19:56:29 +0200
Subject: [PATCH 0/4] Add a DT description of LaCie 2Big and 5Big Network v2
In-Reply-To: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
References: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140417175629.GW27979@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 06:08:54PM +0200, Andrew Lunn wrote:
> This patchset adds a DT description for LaCie 2Big and 5Big, one of
> the last remaining boards in mach-kirkwood. The LEDs cannot be
> described in DT, since there is no binding yet for the device which
> controls them. So a board file is added for that part.
> 
> These patches are build tested only. It would be good if somebody
> could boot them.

Hi Andrew,

Unfortunately, I won't be able to test this patches before two weeks.

Regards,

Simon

> 
> Andrew Lunn (4):
>   ARM: Kirkwood: Add board file for netxbig LEDs
>   ARM: Kirkwood: Add DT descriptions for net2big and net5big.
>   ARM: MVEBU: Add LaCie 2Big and 5Big Network v2
>   ARM: MULTI_V5: Enable LaCie 2Big and 5Big Network v2
> 
>  arch/arm/boot/dts/Makefile              |   2 +
>  arch/arm/boot/dts/kirkwood-net2big.dts  |  25 +++++
>  arch/arm/boot/dts/kirkwood-net5big.dts  |  67 +++++++++++
>  arch/arm/boot/dts/kirkwood-netxbig.dtsi | 182 ++++++++++++++++++++++++++++++
>  arch/arm/configs/multi_v5_defconfig     |   1 +
>  arch/arm/configs/mvebu_v5_defconfig     |   1 +
>  arch/arm/mach-mvebu/Kconfig             |   7 ++
>  arch/arm/mach-mvebu/Makefile            |   1 +
>  arch/arm/mach-mvebu/board-netxbig.c     | 191 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-mvebu/board.h             |   6 +
>  arch/arm/mach-mvebu/kirkwood.c          |   3 +
>  11 files changed, 486 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi
>  create mode 100644 arch/arm/mach-mvebu/board-netxbig.c
> 
> -- 
> 1.9.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140417/95bcd973/attachment.sig>

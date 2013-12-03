From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 03 Dec 2013 21:39:02 +0100
Subject: [PATCH 1/2] ARM: DT: Kirkwood: Use symbolic names from input.h
In-Reply-To: <1386100305-31280-1-git-send-email-andrew@lunn.ch> (Andrew Lunn's
 message of "Tue, 3 Dec 2013 20:51:44 +0100")
References: <1386100305-31280-1-git-send-email-andrew@lunn.ch>
Message-ID: <87fvq9brfd.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

> Replace the numeric key value with a symbolic name from
> <bt-bindings/input/input.h>
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-cloudbox.dts                | 2 +-
>  arch/arm/boot/dts/kirkwood-dnskw.dtsi                  | 6 +++---
>  arch/arm/boot/dts/kirkwood-ib62x0.dts                  | 4 ++--
>  arch/arm/boot/dts/kirkwood-iconnect.dts                | 4 ++--
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts          | 6 +++---
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi                   | 6 +++---
>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts         | 4 ++--
>  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 6 +++---

Jason just applied (yesterday IIRC) to mvebu/dt a series which provides
cleanup for ReadyNAS .dts files. Among other things, it replaces numeric
key values with a symbolic name. And it also does the same for GPIO
voltage level. I guess you can remove that specific .dts from your patch.

Just in case you have the same in preparation for armada .dts files,
RN102 and RN104 .dts files are also fixed in mvebu/dt.

Anyway, thanks for that work.

Cheers,

a+

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 29 Sep 2015 17:34:59 +0200
Subject: [PATCH 00/10] ARM: marvell/dt: add crypto nodes in existing DTs
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
 (Boris Brezillon's message of "Tue, 18 Aug 2015 10:08:51 +0200")
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <871tdhs0gs.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,
 
 On mar., ao?t 18 2015, Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
>
> This series declares and enables the crypto engine on the armada, orion,
> kirkwood and dove SoCs.
>
> Best Regards,
>
> Boris
>

All the patches have been applied on mvebu/dt. I only reworded the commit
title to call them "ARM: mvebu" instead of "ARM: marvell" or "ARM:
marvell/dt". Also for the patch 3 I took your v2.

Thanks,

Gregory

>
> Arnaud Ebalard (1):
>   ARM: marvell/dt: add crypto related nodes to armada 370 dtsi
>
> Boris Brezillon (9):
>   ARM: marvell/dt: add crypto related nodes to armada-xp.dtsi
>   ARM: marvell/dt: define crypto SRAM ranges for all armada-xp boards
>   ARM: marvell/dt: define crypto SRAM ranges for all armada-370 boards
>   ARM: marvell/dt: add crypto related nodes to armada 375 dtsi
>   ARM: marvell/dt: define crypto SRAM ranges in armada-375-db.dts
>   ARM: marvell/dt: add crypto related nodes to armada 38x dtsi
>   ARM: marvell/dt: define crypto SRAM ranges for all armada-38x boards
>   ARM: marvell: use new bindings for existing crypto devices
>   ARM: marvell: modify Orion and Kirkwoord crypto compatible strings
>
>  arch/arm/boot/dts/armada-370-db.dts              |  3 ++-
>  arch/arm/boot/dts/armada-370-dlink-dns327l.dts   |  3 ++-
>  arch/arm/boot/dts/armada-370-mirabox.dts         |  7 ++++-
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts   |  3 ++-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts   |  3 ++-
>  arch/arm/boot/dts/armada-370-rd.dts              |  3 ++-
>  arch/arm/boot/dts/armada-370-synology-ds213j.dts |  3 ++-
>  arch/arm/boot/dts/armada-370.dtsi                | 25 ++++++++++++++++++
>  arch/arm/boot/dts/armada-375-db.dts              |  4 ++-
>  arch/arm/boot/dts/armada-375.dtsi                | 33 ++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-385-db-ap.dts           |  4 ++-
>  arch/arm/boot/dts/armada-385-linksys.dtsi        |  4 ++-
>  arch/arm/boot/dts/armada-388-db.dts              |  4 ++-
>  arch/arm/boot/dts/armada-388-gp.dts              |  4 ++-
>  arch/arm/boot/dts/armada-388-rd.dts              |  4 ++-
>  arch/arm/boot/dts/armada-38x.dtsi                | 33 ++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts        |  4 ++-
>  arch/arm/boot/dts/armada-xp-db.dts               |  4 ++-
>  arch/arm/boot/dts/armada-xp-gp.dts               |  4 ++-
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  |  4 ++-
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts    |  4 ++-
>  arch/arm/boot/dts/armada-xp-matrix.dts           |  4 ++-
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   |  4 ++-
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  4 ++-
>  arch/arm/boot/dts/armada-xp-synology-ds414.dts   |  4 ++-
>  arch/arm/boot/dts/armada-xp.dtsi                 | 30 +++++++++++++++++++++
>  arch/arm/boot/dts/dove.dtsi                      | 17 +++++++++---
>  arch/arm/boot/dts/kirkwood.dtsi                  | 29 ++++++++++++++-------
>  arch/arm/boot/dts/orion5x.dtsi                   | 22 +++++++++++-----
>  29 files changed, 231 insertions(+), 43 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

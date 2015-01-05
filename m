From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 05 Jan 2015 13:03:50 +0100
Subject: [PATCH 00/27] ARM: mvebu: armada-*: Relicense the device tree
 under GPLv2+/X11
In-Reply-To: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <54AA7DA6.3030707@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heikki, Lorenzo, Marcin and Nobuhiro,

On 15/12/2014 16:38, Gregory CLEMENT wrote:
> Hello,
> 
> You've been Cc'd on a relicensing patch, because at some point you
> contributed a patch to an mvebu device tree.
> 
> We're currently moving toward a GPL/X11 dual-license, instead of a GPL
> license like what was done when you submitted your patches.
> 
> This is mostly so that other free software project licensed under a
> BSD-like license, such as the BSD systems, can actually use our DT,
> instead of having to rewrite them on their own.
> 
> Such license changes require the agreement of all the contributors, so
> it would be great, if you agree with the new licensing terms of
> course, that you reply to the patch by giving your acked-by.
> 
> Thanks a lot,


You didn't give your ack (or nack) about the license change for the files
you have contributed. I would like to have your answer on the followings
patches:

For Nobuhiro Iwamatsu:
ARM: mvebu: armada-xp-openblocks-ax3-4: Relicense the device tree under GPLv2+/X11

For Heikki Krogerus:
ARM: mvebu: armada-xp: Relicense the device tree under GPLv2+/X11

For Marcin Wojtas:
ARM: mvebu: armada-38x: Relicense the device tree under GPLv2+/X11
ARM: mvebu: armada-385-db: Relicense the device tree under GPLv2+/X11
ARM: mvebu: armada-375: Relicense the device tree under GPLv2+/X11

For Lorenzo Pieralisi:
ARM: mvebu: armada-370-xp: Relicense the device tree under GPLv2+/X11

And for Ryan Press:
ARM: mvebu: armada-370-mirabox: Relicense the device tree under GPLv2+/X11
ARM: mvebu: armada-370: Relicense the device tree under GPLv2+/X11

Thanks again,

Gregory

> 
> Gregory
> 
> Gregory CLEMENT (27):
>   ARM: mvebu: armada-370-db: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-370: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-370-mirabox: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-370-netgear-rn102: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-370-netgear-rn104: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-370-rd: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-370-synology-ds213j: Relicense the device tree
>     under GPLv2+/X11
>   ARM: mvebu: armada-370-xp: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-375-db: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-375: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-380: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-385-db: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-385: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-385-rd: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-38x: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-xp-axpwifiap: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-xp-db: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-xp: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-xp-gp: Relicense the device tree under GPLv2+/X11
>   ARM: mvebu: armada-xp-lenovo-ix4-300d: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-xp-matrix: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-xp-mv78230: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-xp-mv78260: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-xp-mv78460: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-xp-netgear-rn2120: Relicense the device tree under
>     GPLv2+/X11
>   ARM: mvebu: armada-xp-openblocks-ax3-4: Relicense the device tree
>     under GPLv2+/X11
>   ARM: mvebu: armada-xp-synology-ds414: Relicense the device tree under
>     GPLv2+/X11
> 
>  arch/arm/boot/dts/armada-370-db.dts              | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-370-mirabox.dts         | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 41 +++++++++++++++++++++---
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 41 +++++++++++++++++++++---
>  arch/arm/boot/dts/armada-370-rd.dts              | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-370-synology-ds213j.dts | 41 +++++++++++++++++++++---
>  arch/arm/boot/dts/armada-370-xp.dtsi             | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-370.dtsi                | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-375-db.dts              | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-375.dtsi                | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-380.dtsi                | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-385-db.dts              | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-385-rd.dts              | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-385.dtsi                | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-38x.dtsi                | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-db.dts               | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-gp.dts               | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  | 41 +++++++++++++++++++++---
>  arch/arm/boot/dts/armada-xp-matrix.dts           | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi         | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 41 +++++++++++++++++++++---
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 40 +++++++++++++++++++++--
>  arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 41 +++++++++++++++++++++---
>  arch/arm/boot/dts/armada-xp.dtsi                 | 40 +++++++++++++++++++++--
>  27 files changed, 999 insertions(+), 87 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

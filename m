From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 10 Nov 2013 09:15:33 +0100
Subject: [PATCH] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <527ECBDD.7050607@gmail.com>
References: <87bo1tmibv.fsf@natisbad.org>
	<527ECBDD.7050607@gmail.com>
Message-ID: <20131110091533.463cabb2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Sun, 10 Nov 2013 00:57:17 +0100, Sebastian Hesselbarth wrote:

> >   arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 289 +++++++++++++++++++++++++
> 
> Arnaud,
> 
> thanks for providing this! I do have some comments below.
> 
> we recently had a discussion about the naming of new DTS files, which
> proposes to name those after vendor,board.dts (or vendor-board.dts).
> 
> I personally prefer vendor,board.dts which would give
> netgear,readynas-2120.dts based on your compatible below.
> The final call for ',' vs '-' has not been made, so I  suggest Jason
> makes a call here.

Hum, do we really want that? The current naming scheme is really,
really great, because whenever you want to grep through all Armada
370/XP DTS, you just have to use armada-*, for all Kirkwood,
kirkwood-*. I've found this very very convenient to verify the
coherency between .dts/.dtsi for a given family of SoCs.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

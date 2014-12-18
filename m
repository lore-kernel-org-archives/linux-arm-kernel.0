From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 18 Dec 2014 11:15:27 +0100
Subject: [PATCH 00/27] ARM: mvebu: armada-*: Relicense the device tree
 under GPLv2+/X11
In-Reply-To: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1418897727.4212.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Am Montag, den 15.12.2014, 16:38 +0100 schrieb Gregory CLEMENT:
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

I've only changed a vendor prefix in a compatible entry for each of
arch/arm/boot/dts/armada-370-netgear-rn102.dts,
arch/arm/boot/dts/armada-370-netgear-rn104.dts, and
arch/arm/boot/dts/armada-xp-netgear-rn2120.dts.
Anyway, for those:

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

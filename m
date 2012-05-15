From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 11:55:11 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FB22727.6090406@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch> <4FB22727.6090406@codethink.co.uk>
Message-ID: <20120515115511.75ece9c3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 10:51:35 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> >> You'll find in this patch set the initial support for a new family
> >> of ARMv7-compatible Marvell SoCs, that we have choosen to support
> >> in the arch/arm/mach-armada/ directory.
> 
> I went for the arch/arm/mach-mv-armadaxp as it kept the marvell socs
> together (ignoring kirkwood and dove for the moment).

mach-mv-armadaxp would be a good name if we supported only the Armada
XP SoC, but we also support the Armada 370 SoC within the same
directory. This makes it easy to build a single binary kernel image
that boots and runs on both SoCs.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

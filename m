From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 2 Jul 2012 10:30:16 +0200
Subject: [PATCH v5] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <4FEB2CC3.7090305@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <4FEB2CC3.7090305@codethink.co.uk>
Message-ID: <20120702103016.28b2637e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ben,

Le Wed, 27 Jun 2012 16:54:43 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> It may be something wrong in my device-tree setup, but this is not
> booting for me:
> 
> > Uncompressing Linux... done, booting the kernel.
> > <6>Booting Linux on physical CPU 0
> > <5>Linux version 3.5.0-rc4-11036-g90ad2b7-dirty (ben at rainbowdash) (gcc version 4.4.52
> > CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c53c7d
> > CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> > <6>Machine: Marvell Aramada 370/XP (Device Tree), model: Cogent CSB1726 SoM
> > Memory policy: ECC disabled, Data cache writeback
> > <0>Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.
> 
> This is the last thing I get before it stops. Any ideas on what went
> wrong?

Can you share the device tree you're using for your Cogent platform?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

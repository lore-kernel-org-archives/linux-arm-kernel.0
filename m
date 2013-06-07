From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 17:26:01 +0200
Subject: [PATCH] arm: mvebu: ensure PCIe range is propagated in the .dts
 files
In-Reply-To: <20130607144406.GS23859@titan.lakedaemon.net>
References: <1370510483-32419-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370510483-32419-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606181159.GN23859@titan.lakedaemon.net>
 <20130606190321.GQ23859@titan.lakedaemon.net>
 <20130607103241.3f82d71d@skate>
 <20130607144406.GS23859@titan.lakedaemon.net>
Message-ID: <20130607172601.75b77122@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 7 Jun 2013 10:44:06 -0400, Jason Cooper wrote:

> the patches in mvebu/fixes:
> 
>   8eed481 arm: mvebu: fix the 'ranges' property to handle PCIe
>   c6c003a ARM: mvebu: Fix ranges entry on XP GP board
>   00ed4a0 ARM: mvebu: Add a ranges entry to translate devbus childs
> 
> added the ranges property for openblocks-ax3-4, and the gp, but nothing
> for the db.  The patch
> 
>   b484ff4 ARM: mvebu: Add support for NOR flash device on Armada XP-DB board
> 
> went into mvebu/dt because it was adding new capability.
> 
> So the choices are to make mvebu/dt depend on mvebu/fixes because of
> your patch, or to split the patch because there is no real dependency
> between the two changes.

Ah, ok. That makes sense now. Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

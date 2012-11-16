From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Nov 2012 14:11:34 +0100
Subject: [PATCH 0/6] Add basic support for Allwinner A1X SoCs
In-Reply-To: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121116141134.39ea7b63@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Thu, 15 Nov 2012 23:46:19 +0100, Maxime Ripard wrote:

> You'll find in this patchset the initial support for Allwinner A10 and A13 SoCs
> from Allwinner. Since the internal name of these SoCs are sun4i and sun5i, the
> mach- directory is named sunxi.
> 
> You can find these SoCs in the Cubieboard, the A13-olinuxino or the Melee
> A1000.
> 
> Both SoCs should work fine, as the A13 is a trimmed down version of the A10,
> but it has only been tested on a A13-OlinuXino from Olimex.
> 
> Support is quite minimal for now, since it only includes timer and IRQ
> controller drivers, so we can only boot to userspace through initramfs. Support
> for the other peripherals on these SoCs will come eventually.

Would you mind adding a file Documentation/arm/sunxi/README (or another
name) that lists the SoCs that are supported and the public datasheets
that are available for those SoCs?

I think it's always great to ease the process of finding the SoC
datasheets.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

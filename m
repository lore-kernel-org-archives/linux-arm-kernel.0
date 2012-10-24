From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 16:15:05 +0200
Subject: [PATCH] arm: mvebu: support for the PlatHome OpenBlocks AX3 board
In-Reply-To: <5087AD9A.8020801@free-electrons.com>
References: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <5087AD9A.8020801@free-electrons.com>
Message-ID: <20121024161505.62eee02b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 24 Oct 2012 10:58:02 +0200, Gregory CLEMENT wrote:
> On 10/23/2012 10:19 AM, Thomas Petazzoni wrote:
> > This platform, available in Japan from PlatHome, has a dual-core
> > Armada XP, the MV78260. For now, only the two serial ports and the
> > three front LEDs are supported. Support for network, SATA, USB and
> > other peripherals will be added as drivers for them become available
> > for Armada XP in mainline.
> And don't forget the SMP support too, MV78260 is supposed to have 2 cores.

Sure. My plan is to progressively add support for other devices and
features (SMP included) as we get them merged in mainline.

> Besides this, this patch looks good. I have applied it on a v3.7-rc2
> without any problem, and managed to build it also.
> So you can add my
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

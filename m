From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 16:16:11 +0200
Subject: [PATCH] arm: mvebu: update defconfig with 3.7 changes
In-Reply-To: <5087A94E.4000706@free-electrons.com>
References: <1350980269-6587-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <5087A94E.4000706@free-electrons.com>
Message-ID: <20121024161611.659b0989@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 24 Oct 2012 10:39:42 +0200, Gregory CLEMENT wrote:
> On 10/23/2012 10:17 AM, Thomas Petazzoni wrote:
> > The split of 370 and XP into two Kconfig options and the multiplatform
> > kernel support has changed a few Kconfig symbols, so let's update the
> > mvebu_defconfig file with the latest changes.
> 
> Indeed this patch fixes the mvebu_defconfig which was broken.
> But as now mvebu is part of multi_v7_defconfig, shouldn't we just
> removed mvebu_defconfig ?

I think for now, SoC family specific defconfig files are still
accepted, so I'd prefer to keep mvebu_defconfig around. Multiplatform
is nice for users, but I prefer to build a mvebu-only kernel when I'm
doing kernel development.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

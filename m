From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 14:54:12 +0200
Subject: [PATCH 7/8] arm: mach-armada: add defconfig
In-Reply-To: <4FB228CF.9040508@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228CF.9040508@codethink.co.uk>
Message-ID: <20120515145412.0bdb05d9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 10:58:39 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> > diff --git a/arch/arm/configs/armada_defconfig
> > b/arch/arm/configs/armada_defconfig new file mode 100644
> 
> personally, I'd go for armadaxp_defconfig.

Unfortunately, this would be very confusing: we support both Armada XP
and Armada 370 here.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

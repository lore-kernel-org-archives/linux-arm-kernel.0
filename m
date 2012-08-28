From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 23:57:29 +0200
Subject: arm: move plat-orion platform_data headers to the right place
In-Reply-To: <20120828211503.GM19437@titan.lakedaemon.net>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120828201134.GM9886@lunn.ch>
 <20120828202534.GK19437@titan.lakedaemon.net>
 <20120828211503.GM19437@titan.lakedaemon.net>
Message-ID: <20120828235729.0f4e792f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 28 Aug 2012 17:15:03 -0400,
Jason Cooper <jason@lakedaemon.net> a ?crit :

> Ok, built the following defconfigs with a generic powerpc toolchain:
> 
> c2k_defconfig
> chrp32_defconfig
> prpmc2800_defconfig

I also built the following PowerPW defconfigs, which had either the I2C
or the Ethernet Marvell drivers enabled, or both:

 c2k
 chroma
 chrp32
 mpc7448_hpc2
 pasemi
 ppc6xx
 prpmc2800

All of them built, except mpc7448_hpc2, but the build failure was
completely unrelated.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

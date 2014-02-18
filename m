From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Feb 2014 13:45:32 +0100
Subject: [PATCH] net: ethernet: remove unneeded dependency of mvneta and
 update help text
In-Reply-To: <20140218122952.GM7862@titan.lakedaemon.net>
References: <1392719391-8851-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218122952.GM7862@titan.lakedaemon.net>
Message-ID: <20140218134532.7607a616@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 18 Feb 2014 07:29:52 -0500, Jason Cooper wrote:

> >  config MVNETA
> > -	tristate "Marvell Armada 370/XP network interface support"
> > -	depends on MACH_ARMADA_370_XP
> 
> Have you build-tested this on the usual fail scenarios?  eg x86_64,
> powerpc, s390, allno, allyes, allmod, etc?
> 
> I think you might be opening up pandora's box here without needing to.
> :)

No, I haven't tested all the build scenarios of course. If you feel
that this is too dangerous, I can resend a patch that replaces 'depends
on ARMADA_370_XP' by 'depends on PLAT_ORION'. Would this be OK for you?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: aspotashev@emcraft.com (Alexander Potashev)
Date: Wed, 28 Dec 2011 13:51:22 +0400
Subject: Renaming MACH_TYPE_KINETIS_K60 into MACH_TYPE_KINETIS
Message-ID: <1325065882.1584.153.camel@skywanderer.emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

About three weeks ago I registered a machine type for the Freescale
Kinetis K60 microcontroller. ( http://www.arm.linux.org.uk/developer/machines/list.php?id=3896 )

But later I realized that there should be a single machine type for all
Freescale Kinetis MCUs (K10 through K70), because those MCUs are
software-compatible. I tried to rename "kinetis_k60" to just "kinetis"
at the page mentioned above, but the names of the CONFIG_* macro and the
identifier name did not change.

I really do not want to register another machine type since it would be
a mess having two machine types - one for Kinetis and another for
Kinetis K60. Is it possible to change CONFIG_MACH_KINETIS_K60 to
CONFIG_MACH_KINETIS and MACH_TYPE_KINETIS_K60 to MACH_TYPE_KINETIS in
the database at http://www.arm.linux.org.uk/developer/machines/ ?

I hope, no one has really started using this machine type yet, so the
change is going to be transparent for everyone.


-- 
Regards,
Alexander

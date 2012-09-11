From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 15:49:03 +0200
Subject: [PATCH v4] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <201209111310.00347.arnd@arndb.de>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201209111310.00347.arnd@arndb.de>
Message-ID: <20120911154903.613da470@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 11 Sep 2012 13:10:00 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> Excellent!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

> Just one small comment for the very last patch:
> 
> >  (7) Patch 17 adds the necessary DT code to instantiate the address
> >      decoding "controller".
> > 
> 
> This one seems to lack a device tree binding document.

Good point, I'll add some documentation.

Thanks again,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

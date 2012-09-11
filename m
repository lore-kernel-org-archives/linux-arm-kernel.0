From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 17:45:01 +0200
Subject: [PATCH v4] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <201209111310.00347.arnd@arndb.de>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201209111310.00347.arnd@arndb.de>
Message-ID: <20120911174501.2ddec831@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Le Tue, 11 Sep 2012 13:10:00 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> Excellent!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Related to this patch set, I have a question: wouldn't it make sense to
make the .virtual field of struct map_desc anvoid __iomem pointer as
well instead of an unsigned long? This would avoid all the (unsigned
long) casts in map_descs array definitions, and would be a bit more
consistent, no?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

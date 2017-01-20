From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Thu, 19 Jan 2017 20:55:30 -0500
Subject: [PATCH v5 2/2] net: dsa: mv88e6xxx: Add support for ethernet
 switch 88E6341
In-Reply-To: <20170120001203.GB31483@lunn.ch>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
 <20170119214934.27442-3-gregory.clement@free-electrons.com>
 <87y3y6k7pg.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <20170120001203.GB31483@lunn.ch>
Message-ID: <87a8am1oml.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

>> Maybe I missed it, Andrew, can you confirm that 6341 is a proper Marvell
>> family of switch chips?
>
> My understand is that it is. Marvell have not added it to DSDT. There
> is a new SDK called UMSD, also GPLv2 and BSD. They call this family
> Topaz, and the 6390 is Peridot.

At least we could rename it anytime. They don't really make sense nor or
reliable anyway...

Thanks,

        Vivien

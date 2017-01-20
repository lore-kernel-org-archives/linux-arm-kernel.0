From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Fri, 20 Jan 2017 12:30:16 -0500
Subject: [PATCH v5 2/2] net: dsa: mv88e6xxx: Add support for ethernet
 switch 88E6341
In-Reply-To: <8760l9641t.fsf@free-electrons.com>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
 <20170119214934.27442-3-gregory.clement@free-electrons.com>
 <87y3y6k7pg.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <20170120001203.GB31483@lunn.ch> <8760l9641t.fsf@free-electrons.com>
Message-ID: <87lgu5r653.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> If there a series about to be merged I can rebase my series on it. Else
> I propose to keep it and convert the family check to ops when you will
> send the series for it.

I am reworking the VTU operations, but not these port operations yet.
I will take care of converting the family checks once I'm done, don't
worry ;)

> I confirm that 6141 and 6341 are called Topaz. Actually I can add the
> support for the 6141 too, it is just a matter of adding an ID and maybe
> removing some ops as 6141 is a subset of 6341.

I don't mind having a patch adding support for only one chip at a time,
that is up to you.

Thanks,

        Vivien

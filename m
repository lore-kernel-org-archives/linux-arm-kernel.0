From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 17:00:20 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FB26E4B.4020609@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB26E4B.4020609@codethink.co.uk>
Message-ID: <20120515170020.23c68cac@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 15:55:07 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> > This preliminary support only includes the necessary code for timer
> > and IRQ support, the serial controller is a standard
> > 16550-compatible one. The diffstat looks like:
> 
> FYI, built and tested on our system here and it gets to
> printing the sched_clock line and getting no further.
> 
> I will have a debug.

Hum, strange. On which platform exactly?

I've built from scratch a kernel image this morning and boot tested it
on both the DB-78460-BP (Armada XP) and DB-88F6710-BP (Armada 370) this
morning, and it was working.

> The only comment so far other than the review issues is that
> we needed to enable CONFIG_HIGMEM to get >780MiB of memory
> as this system comes with 2048MiB as standard.

Good point. Will do.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

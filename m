From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 17:39:09 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205151527.01156.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB269CB.4080804@gmail.com> <20120515164438.22258885@skate>
 <201205151527.01156.arnd@arndb.de>
Message-ID: <20120515173909.383a0d8a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 15:27:00 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> The problem with mach-marvell is that it would be confusing in the
> presence of pxa/mmp which I would probably still leave out of that
> directory, since they are rather different inside.

Sure.

> I think we can just start with the existing plat-orion directory until
> someone comes up with a better place.

So you want us to put all this new source code that typically belongs
to a mach-* directory into plat-orion/ ?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

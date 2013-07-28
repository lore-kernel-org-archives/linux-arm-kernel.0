From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 28 Jul 2013 15:37:29 +0200
Subject: N900 device tree conversion: how to do first step
In-Reply-To: <20130719181416.GA1204@earth.universe>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
 <20130719181416.GA1204@earth.universe>
Message-ID: <20130728133728.GA5382@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I'd like to convert Nokia N900 to device tree.
> > 
> > Unfortunately, serial port is not easily available (very special cable
> > would be needed, does someone know where to get one?)
> 
> One way to get one is building it yourself. I finished mine yesterday:
> 
> http://elektranox.org/n900/adapter/index.html

Nice but a bit above my hardware hacking skills. For now, I'm using
automated scripts to run qemu... (They are available at 

http://tui.cvs.sourceforge.net/viewvc/tui/tui/auto/

). They should allow automated testing for regressions and automatic
bisect.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

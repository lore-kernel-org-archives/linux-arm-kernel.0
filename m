From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 16 Jan 2010 23:14:54 +0100
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <201001162307.48085.rjw@sisk.pl>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001152314.30355.rjw@sisk.pl> <20100116181211.GA1603@ucw.cz>
	<201001162307.48085.rjw@sisk.pl>
Message-ID: <20100116221454.GA8425@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Agreed, but so what? On PC, machine would power off at that
> > point. That would surprise the apps, too.
> > 
> > Basically new enough userland should not make battery run low enough
> > for either emergency power off or emergency suspend.
> 
> I wonder how it is supposed to achieve that without knowing the current battery
> status.  Do you mean it should poll the battery driver?

That's besides point, is it?

Usual kernel<->user interfaces should apply here. Zaurus provides
/proc/apm emulation, and I'm writing drivers/power/ driver. Not sure
it has event interface...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

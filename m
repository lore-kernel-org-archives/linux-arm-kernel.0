From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 1 Apr 2010 08:06:25 +0200
Subject: [regression] 2.6.34-rc1 to -rc3 on zaurus: no longer boots
In-Reply-To: <20100315102830.GA10288@atrey.karlin.mff.cuni.cz>
References: <20100313122754.GD2192@elf.ucw.cz>
	<20100315102830.GA10288@atrey.karlin.mff.cuni.cz>
Message-ID: <20100401060624.GA1329@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I tried compiling 2.6.34-rc1, and it does not boot :-(. It does not
> > seem to even reset the framebuffer (I'm using kexec -- so it stays
> > stuck on on previous screen).

Tried again with -rc2 and -rc3, and neither boots :-(. I did not have
time to set up serial console, yet :-(. Any ideas?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

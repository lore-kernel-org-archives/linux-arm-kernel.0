From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 8 Apr 2010 06:44:09 +0200
Subject: [regression] 2.6.34-rc1 to -rc3 on zaurus: no longer boots
In-Reply-To: <201004072252.08354.marek.vasut@gmail.com>
References: <20100313122754.GD2192@elf.ucw.cz> <20100401060624.GA1329@ucw.cz>
	<201004072226.34272.maciej.rutecki@gmail.com>
	<201004072252.08354.marek.vasut@gmail.com>
Message-ID: <20100408044409.GA14982@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2010-04-07 22:52:08, Marek Vasut wrote:
> Dne St 7. dubna 2010 22:26:34 Maciej Rutecki napsal(a):
> > On czwartek, 1 kwietnia 2010 o 08:06:25 Pavel Machek wrote:
> > > Hi!
> > >
> > > > > I tried compiling 2.6.34-rc1, and it does not boot :-(. It does not
> > > > > seem to even reset the framebuffer (I'm using kexec -- so it stays
> > > > > stuck on on previous screen).
> > >
> > > Tried again with -rc2 and -rc3, and neither boots :-(. I did not have
> > > time to set up serial console, yet :-(. Any ideas?
> > 
> > I created a Bugzilla entry at
> > https://bugzilla.kernel.org/show_bug.cgi?id=15712
> > for your bug report, please add your address to the CC list in there,
> >  thanks!
> > 
> Pavel, you broke it ... and here you say something about sane arm maintainers 
> ;-)

? You know which patch causes it ?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

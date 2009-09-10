From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Sep 2009 21:05:18 +0200
Subject: [patch for 2.6.31] zaurus c3000 aka spitz: fix resume
In-Reply-To: <f17812d70909091740m3ef98e44t18dffc6a2c7c1126@mail.gmail.com>
References: <20090909075024.GA1400@ucw.cz> <1252507740.14793.115.camel@desktop>
	<f17812d70909091740m3ef98e44t18dffc6a2c7c1126@mail.gmail.com>
Message-ID: <20090910190518.GC23356@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2009-09-10 08:40:24, Eric Miao wrote:
> On Wed, Sep 9, 2009 at 10:49 PM, Daniel Walker <dwalker@fifo99.com> wrote:
> > On Wed, 2009-09-09 at 09:50 +0200, Pavel Machek wrote:
> >> Hi, Linus!
> >>
> >> Spitz resume was broken for year or likely two, and it would be very
> >> nice to fix it for 2.6.31 release. One liner is below, and it really
> >> can not harm. It already is in Eric's fix queue, so pulling that for
> >> .31 should work, too.
> >>
> >> Do you think you could take it?
> >
> > One checkpatch error here..
> >
> > ERROR: trailing whitespace
> > #77: FILE: arch/arm/mach-pxa/sharpsl_pm.c:681:
> > +^Iif ((!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) || $
> >
> > total: 1 errors, 0 warnings, 10 lines checked
> >
> 
> This has been fixed in the version I sent to Russell.

Thanks and sorry for the noise. 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

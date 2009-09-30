From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 30 Sep 2009 22:12:56 +0200
Subject: 2.6.32-rc1: spitz boots but suspend/resume is broken
In-Reply-To: <bc64b4640909300509p6c682fa8rb5ce43c77c79f5@mail.gmail.com>
References: <20090930120655.GG1412@ucw.cz>
	<bc64b4640909300509p6c682fa8rb5ce43c77c79f5@mail.gmail.com>
Message-ID: <20090930201256.GA1398@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-09-30 16:09:25, Dmitry Eremin-Solenikov wrote:
> On Wed, Sep 30, 2009 at 4:06 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > matrix keyboard driver needs to be enabled, otherwise it seems ok.
> >
> > Unfortunately, it does not respond to power button in any visible way
> > :-(. Any ideas what might be wrong/how to debug it?
> 
> Enable gpio-keyboard driver, verify (or port power button to it :))
> and check that
> enable_wakeup is enabled.

Is there easy way to enable old driver, first?

I'd like to verify that nothing else broke... there were tons of
changes in rc1.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Oct 2009 22:56:12 +0100
Subject: staging/dream: add gpio and pmem support
In-Reply-To: <20091028155116.GA1434@kroah.com>
References: <20091022091333.GA31023@elf.ucw.cz>
	<20091026234332.GB26583@kroah.com>
	<20091027001702.GA5019@elf.ucw.cz>
	<20091027030039.GA6195@kroah.com>
	<20091027081921.GG5019@elf.ucw.cz>
	<20091027165750.GA24477@kroah.com>
	<20091027193330.GB19379@elf.ucw.cz>
	<20091027204445.GA28878@kroah.com>
	<20091027232521.GA16782@elf.ucw.cz>
	<20091028155116.GA1434@kroah.com>
Message-ID: <20091028215612.GB8053@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > With this patch, will it build properly?
> > 
> > Its certainly way closer to building... it builds for me, with
> > something like below; platform devices really are initialized from
> > board-* files and get passed parameters.
> 
> Ick.  This isn't ok, we can't take patches for staging stuff in files
> outside of drivers/staging/

I know, I was trying to show that ammount of required changes is very small.

> So for now, I've deleted the drivers/staging/dream/ directory from my
> tree, which will get pushed for 2.6.33.  Please clean the code up and
> get it into buildable shape and I will be glad to add the drivers back
> into the staging directory at that time.

Ok, I got something that builds; verifying it on device is hard, as
last kernel that boots there is 2.6.29...

Should I turn it into series and submit?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

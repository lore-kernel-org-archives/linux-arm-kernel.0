From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 28 Apr 2011 22:36:59 +0200
Subject: [Zaurus-devel] 2.6.39-rc5 on zaurus: works
In-Reply-To: <20110408082827.GD3180@jama.jama.net>
References: <20110408062646.GA1472@ucw.cz>
	<201104080931.11202.marek.vasut@gmail.com>
	<20110408082827.GD3180@jama.jama.net>
Message-ID: <20110428203659.GA22663@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Build fix is below. Maybe it is pending in the trees somewhere
> > > already...
> > 
> > Fix is already there, it was broken by a patch from someone recently. Thanks 
> > though
> > > 
> > > Boot stops just after mounting root filesystem; cursor stops
> > > flashing. (Any idea what goes on there?)
> > 
> > No idea, it works for me and doesn't hang ;-)
> 
> it works here too with rev 6221f222c0ebf1acdf7abcf927178f40e1a65e2a

I had problems mounting filesystems; good news is that in 2.6.39-rc5
these are fixed.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

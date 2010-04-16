From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 16 Apr 2010 22:12:45 +0200
Subject: 2.6.34-rc3 vs zaurus spitz: mistery solved
In-Reply-To: <x2qf17812d71004152325v26785671r23aafd9444614590@mail.gmail.com>
References: <20100415180314.GC1443@ucw.cz>
	<x2qf17812d71004152325v26785671r23aafd9444614590@mail.gmail.com>
Message-ID: <20100416201245.GB13350@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2010-04-16 14:25:16, Eric Miao wrote:
> On Fri, Apr 16, 2010 at 2:03 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > For some reason, spitz will hang very early in boot with SLUB. With
> > SLOB, it boots fine.
> >
> 
> Weird, just wondering for what specific reason. Pavel, could you possibly
> paste the failure log if possible?

Investigating... So far it seems that either it was fixed in -rc4 or
that slub debugging options cause the problem.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

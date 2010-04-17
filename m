From: metan@ucw.cz (Cyril Hrubis)
Date: Sat, 17 Apr 2010 21:00:53 +0200
Subject: 2.6.34-rc3 vs zaurus spitz: mistery solved
In-Reply-To: <20100416201245.GB13350@elf.ucw.cz>
References: <20100415180314.GC1443@ucw.cz>
	<x2qf17812d71004152325v26785671r23aafd9444614590@mail.gmail.com>
	<20100416201245.GB13350@elf.ucw.cz>
Message-ID: <20100417190053.GA4611@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> > > For some reason, spitz will hang very early in boot with SLUB. With
> > > SLOB, it boots fine.
> > >
> > 
> > Weird, just wondering for what specific reason. Pavel, could you possibly
> > paste the failure log if possible?
> 
> Investigating... So far it seems that either it was fixed in -rc4 or
> that slub debugging options cause the problem.

rc4 is working for me, so it looks like this was fixed, or at least works again
now.

-- 
metan

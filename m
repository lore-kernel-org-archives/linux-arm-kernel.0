From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Aug 2011 11:15:03 +0200
Subject: Fwd: [GIT PULL] [3.2] Please pull tegra boards for 3.2
In-Reply-To: <20110826083252.GE11250@n2100.arm.linux.org.uk>
References: <CAOesGMjHN-pvVfMN0o3AD238m8wEiRS-D4ArjV_2VAGTuwPfBw@mail.gmail.com>
	<201108161648.58250.arnd@arndb.de>
	<CAOesGMgZCFF=dWhAm_+Ux-c-aORqo4sJ1DOGirCu3QT-iMcQRQ@mail.gmail.com>
	<2300535.b0zjAbUTLi@wuerfel>
	<CAOesGMj5P9yLO0My4UB7AEj+9NdmYq8HYwVMd3Uv1NQO6+WP7A@mail.gmail.com>
	<20110826083252.GE11250@n2100.arm.linux.org.uk>
Message-ID: <20110826091503.GG7526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 09:32:52AM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 25, 2011 at 10:23:21PM -0700, Olof Johansson wrote:
> > Ok. Sounds like there might be some use for a temporary "work in
> > progress" branch for linux-next for patches that are nearly ready to
> > go but not quite that needs air time, but not really for anything
> > beyond that.
> 
> Bad idea.
> 
> linux-next's policy is that everything in linux-next should be ready
> for mainline - not nearly ready.
> 
> Linus is threatening at the next merge window to ignore pull requests
> from maintainers, and just pull the entire linux-next tree into his at
> the beginning.  Anything in linux-next which is "work in progress" will
> therefore find its way immediately into mainline in whatever state it's
> in.

Are you referring to:

> In fact, I'm seriously considering a rather draconian measure for next
> merge window: I'll fetch the -next tree when I open the merge window,
> and if I get anything but trivial fixes that don't show up in that "next
> tree at the point of merge window open", I'll just ignore that pull
> request. Because clearly people are just not being careful enough.

I understood that he wants to check if the contents of a pull request
are already in -next and otherwise just refuses to pull. SO nothing
changes, except that you have to make sure your patches are in -next
before the merge window opens.

There may be something else on the lists I missed...

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

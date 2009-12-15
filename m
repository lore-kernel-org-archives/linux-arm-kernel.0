From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 15 Dec 2009 20:09:27 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <a55d774e0912131338x6d44b5c9s5655c549ac594815@mail.gmail.com>
References: <20091208102842.GH12264@elf.ucw.cz>
	<20091208224550.GA26915@n2100.arm.linux.org.uk>
	<d6200be20912081639mdd853bg4080f415116d018c@mail.gmail.com>
	<20091209113739.GC22752@elf.ucw.cz>
	<1260375495.23633.175.camel@desktop>
	<20091213212918.GE5114@elf.ucw.cz>
	<a55d774e0912131338x6d44b5c9s5655c549ac594815@mail.gmail.com>
Message-ID: <20091215190927.GA26422@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2009-12-13 13:38:16, Brian Swetland wrote:
> On Sun, Dec 13, 2009 at 1:29 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >>
> >> I'm going to end up pulling a lot of these git commit into my git tree.
> >> It would be pretty easy for me to just pull this GPIO change directly ..
> >> I assume you haven't found a way to work with git that suites you? It
> >> would be best if you used git, but I could try to do some sort of quilt
> >> export if that works better for you.
> >
> > I can easily "pull" git trees. I do my own work in git, but usually
> > not in a way that would be useful for pushing upstream (see my trees
> > at git.kernel.org).
> >
> > I *could* add my dream trees to those that are mirrored at kernel.org,
> > when things settle a bit. (Should I?)
> >
> > But I'd really prefer to push my stuff using plain old patches in
> > emails.
> 
> It would probably be helpful for those of us at Google and Qualcomm,
> who have an entirely git-based workflow to be able to pull patches
> from somewhere, especially if you already have trees that you could
> publish and it's not a huge burden on you.

I do have git trees, but you do not want to pull from them. Getting
the trees into state where you'd want to pull from them would be quite
hard.

> What has worked well for me the last couple times I've sent patches
> out was to put them in an outgoing git branch somewhere, use the git
> tools to email them to lkml/lakml for review, and include a pointer to
> the git://... that people can pull from -- sorta the best of both
> worlds.

Well, I guess dwalker's tree can serve as a clean/easy place to pull
from.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

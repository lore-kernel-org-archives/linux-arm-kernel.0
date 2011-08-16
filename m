From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 23:12:33 +0200
Subject: Fwd: [GIT PULL] [3.2] Please pull tegra boards for 3.2
In-Reply-To: <CAOesGMgZCFF=dWhAm_+Ux-c-aORqo4sJ1DOGirCu3QT-iMcQRQ@mail.gmail.com>
References: <CAOesGMjHN-pvVfMN0o3AD238m8wEiRS-D4ArjV_2VAGTuwPfBw@mail.gmail.com>
	<201108161648.58250.arnd@arndb.de>
	<CAOesGMgZCFF=dWhAm_+Ux-c-aORqo4sJ1DOGirCu3QT-iMcQRQ@mail.gmail.com>
Message-ID: <2300535.b0zjAbUTLi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 August 2011 12:30:50 Olof Johansson wrote:
> On Tue, Aug 16, 2011 at 7:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The contents all look good, but I'm undecided whether we should have
> > branches that are not based on a -rc release. In your case, it's
> > halfway between -rc1 and -rc2.
> >
> > Do others have an opinion? If we decide to take development branches
> > only when they are based on a proper -rc, I'll do the simple rebase
> > of the patches and push them out, otherwise I'll push them as they are.
> 
> I guess it depends on what you and others prefer -- if you want to
> aggregate the branches in arm-soc.git through the development weeks,
> or if you prefer to get most of the merge requests when platform
> maintainers are getting ready for the merge window and feeding things
> up?

I definitely want to have the patches as early as possible, but not
more than one pull request per branch per week or -rc ideally.

> Either is fine with me -- if it's easier for me to hold off the merge
> requests a while, then I'll start a for-next branch and ask Stephen to
> add it, and rebase it a few times up until when the merge request to
> arm-soc is sent. Maybe it's just easier for everyone to do it that way
> -- the drawback is that there's less visibility about what's about to
> go in until the merge requests start to drop in late in the cycle. The
> git history won't be quite as wide then either.

I would prefer to have all branches that I send to Linus go into the
-next through the arm-soc tree as well, not get sent there individually.

Basically, when you consider patches stable and ready for upstream
and expect no further changes, I'll pull the patches into arm-soc.git
and you can add further patches on top of the branch that I have already
pulled (not on an aggregated branch) and I can pull that again. If you
have unrelated changes, then I'd prefer them to be on top of an -rc
release for the next pull request.

	Arnd

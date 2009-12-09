From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Dec 2009 12:43:28 +0000
Subject: [GIT PULL] Patches for 2.6.33-rc1
In-Reply-To: <1260356671.19669.1296.camel@localhost>
References: <1260353349.13499.4.camel@pc1117.cambridge.arm.com>
	<1260354044.19669.1267.camel@localhost>
	<1260355174.13499.8.camel@pc1117.cambridge.arm.com>
	<1260356671.19669.1296.camel@localhost>
Message-ID: <1260362608.13499.19.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-09 at 11:04 +0000, Artem Bityutskiy wrote:
> On Wed, 2009-12-09 at 10:39 +0000, Catalin Marinas wrote:
> > On Wed, 2009-12-09 at 10:20 +0000, Artem Bityutskiy wrote:
> > > It is so much helpful when people add proper prefixes to patches, like
> > > ARM or something. I wander, do we have a requirement for this somewhere?
> > > But please, consider doing this, this makes it easier surfing git-log or
> > > gitk info.
> >
> > It would be useful, indeed, so I haven't seen an official statement from
> > Russell on this (and I usually run gitk on specific directories).
> >
> > Traditionally we used the patch system which was adding a prefix but
> > since it cannot cope with a different author from the submitter, I just
> > use Git these days (I don't mind either way).
> 
> Well, for people like me who did not use the patch system long time
> before and did not get accustomed to it, the system is looks very
> ancient and sub-standard.
> 
> But since I'm not an ARM developer, I do complain about this. If ARM
> people find the system good, and the standard lkml-sytle patch exchange
> culture does not work for them - fine :)

The patches are posted and review on this list as on LKML. The patch
system is used only for the final stage before being merged and only
after being acknowledged on the list. Just an alternative to git
request-pull.

-- 
Catalin

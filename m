From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 17 Sep 2011 10:08:30 +0900
Subject: [GIT PULL] Samsung Fixes for v3.1-rc7
In-Reply-To: <1642876.jgt6epCtEP@wuerfel>
References: <00b101cc738d$bcf46ce0$36dd46a0$%kim@samsung.com>
	<00cf01cc7466$e2cd66e0$a86834a0$%kim@samsung.com>
	<20110916134300.GB16280@suse.de> <1642876.jgt6epCtEP@wuerfel>
Message-ID: <00d801cc74d6$50d93fa0$f28bbee0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Friday 16 September 2011 15:43:00 Greg KH wrote:
> > > In this case, I'm not sure which following method is proper...
> > > - to send 'pull request' to Greg / stable at kernel.org like bug fix
during -rc
> > > - to submit each patches with adding 'Cc: stable at kernel.org' again
> > > - or ?
> 
> The patches are currently queued in the stable branch of the arm-soc
> tree, I haven't forwarded them to Linus yet. I can easily change
> the changelog before I actually send them on (if you tell me which ones
> they are, or I can pull an updated set of patches to replace them.
> 
Arnd, I think, would be better to me if you could not change the
changelog(commit id) because some my topic branch which is for v3.2 has it.

> > Are these in Linus's tree already?  If so, send me the git commit ids
> > and I will add them to the stable kernels.
> >
> > If not, wait until they are, and then send me the git commit ids, and I
> > will then add them.
> 
> This is fine with me as well, but I'm trying to get more people to
> send me patches that are annotated already. I forgot to ask during
> the last set of bug fixes I forwarded and should probably go through
> the ones that are already merged and ask the authors about backporting.
> 
I need to sort out commit ids which are needed to apply in stable among
Samsung stuff already in mainline.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

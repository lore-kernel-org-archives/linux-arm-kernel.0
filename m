From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 22 Dec 2013 23:39:53 +0100
Subject: [GIT PULL 7/7] Samsung SoC for v3.14
In-Reply-To: <20131222221141.GF13365@quad.lixom.net>
References: <52AE0FA5.3090804@samsung.com>
 <20131222221141.GF13365@quad.lixom.net>
Message-ID: <1566886.jecinlyiQ0@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Sunday 22 of December 2013 14:11:41 Olof Johansson wrote:
> On Mon, Dec 16, 2013 at 05:23:01AM +0900, Kukjin Kim wrote:
> > The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> > 
> >   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> > 
> > are available in the git repository at:
> > 
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-soc
> > 
> > for you to fetch changes up to 538cfbb4c40ab59688236484138133b8e3e89220:
> > 
> >   ARM: dts: Add initial support for Arndale Octa board (2013-12-16
> > 05:05:43 +0900)
> 
> Hi,
> 
> I'm not going to pull this.
> 
> I've asked you for about 6 months now (ever since Arnd went on leave)
> to please finish his multiplatform work for Exynos. Nothing has happened.
> 
> I'm not going to merge any more platform or SoC enablement code
> for Samsung platforms until Exynos has been converted over to
> multiplatform. Sorry.

Well, it's hard to disagree with you on this. Keeping adding new things
constantly definitely does not make us closer to multiplatform support,
as it only increases codebase of code that needs to be cleaned up and made
multiplatform aware.

However it's not that we're not doing anything towards mutliplatform
support. We're slowly getting there. A bit too slowly, but I'm afraid
this is due to the fact that we have definitely too little manpower
working on mainline support of Samsung SoCs.

As for good news, I already have a series cleaning up PM/sleep support
and making it multiplatform friendly and I'm going to post it tomorrow.
The bad news is that it depends on other series and I'm not sure if we
can get it merged in this release. I'll try to do whatever possible to
merge things as soon as possible, though.

>From smaller things, we still need to sort out Exynos cpufreq driver that
has dependencies on headers in plat-samsung/ and mach-exynos/.
Unfortunately I don't have so much time to work on all the things at the
same time, so I hope that someone else could pick this task up. Marek,
Lukasz, what do you think?

Best regards,
Tomasz

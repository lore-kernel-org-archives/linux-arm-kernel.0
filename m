From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 1 Jul 2011 10:51:06 +0300
Subject: [GIT PULL] omap iommu fixes for v3.0-rc
In-Reply-To: <20110701070056.GZ23145@atomide.com>
References: <BANLkTi=vd2TE6JjueGmY=ydRQRygo8-Q1Q@mail.gmail.com>
	<20110701070056.GZ23145@atomide.com>
Message-ID: <BANLkTikhZhUzyk=31cUOcV3Ygj=BHUrbew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 1, 2011 at 10:00 AM, Tony Lindgren <tony@atomide.com> wrote:
> These look like real fixes, but can you please update the commits
> with something like "This fixes an issue with foo when doing bar".

Done, please tell me if it's OK now.

> Otherwise it's easy to claim that these are "fixes for features that
> never worked" and it might be hard to justify them this late into
> the -rc cycle.

It seems we did have these issues for quite some time, and these are not
explicit 3.0 regressions. So they might vaguely fall into the "fixes
for features that never worked" definition too in a sense.

If you prefer to take them into 3.1, that's OK too.

Thanks,
Ohad.

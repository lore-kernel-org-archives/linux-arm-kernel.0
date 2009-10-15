From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Oct 2009 17:19:53 -0700
Subject: [PATCH 00/17] Massive OMAP730/OMAP850 cleanup
In-Reply-To: <3d374d00910141712o6db73c8ejf2e49e4a65b758d6@mail.gmail.com>
References: <3d374d00910141250h22e18bccpa6792d2a323b61f8@mail.gmail.com>
	<20091014211206.GL12700@atomide.com>
	<3d374d00910141712o6db73c8ejf2e49e4a65b758d6@mail.gmail.com>
Message-ID: <20091015001953.GE14531@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alistair Buxton <a.j.buxton@gmail.com> [091014 17:13]:
> 2009/10/14 Tony Lindgren <tony@atomide.com>:
> > * Alistair Buxton <a.j.buxton@gmail.com> [091014 13:03]:
> >> Reposting the full series for review. Assuming this is all OK would it
> >> be a good idea to merge the config variables into a single
> >> CONFIG_ARCH_OMAP7XX? There doesn't seem to be any reason to have both.
> >> Original description follows.
> >
> > Yeah, those should be merged too. Let's do that as a separate patch.
> 
> On a related note, the omap850.h and omap730.h should go away too,
> when everyone is happy with the new omap7xx.h. Perhaps we should add a
> #warning to them so people know they will be removed at some point?

OK, let's do that, but let's first get all the recently posted patches
merged into the omap for-next branch. After that we can have some
static commit on which to create more patches.

Regards,

Tony

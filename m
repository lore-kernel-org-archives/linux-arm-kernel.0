From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 12 Oct 2011 15:49:09 -0700
Subject: [PATCH v4 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <20111012224131.GD25128@quad.lixom.net>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
	<1318371375-4083-3-git-send-email-swarren@nvidia.com>
	<20111012224131.GD25128@quad.lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE19F15@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, October 12, 2011 4:42 PM:
> On Tue, Oct 11, 2011 at 04:16:14PM -0600, Stephen Warren wrote:
> > v3: Make regs variable static. Remove empty init of tegra_gpio_banks.
> >
> > v2: Retrieve IRQ and memory addresses from resources instead of hard-
> > coding them. Add back initialization of tegra_gpio_chip.of_node.
> 
> In the future, please move the revision log to below the ---, and just have
> the main patch description above, since that is what goes into the git repo.

I don't quite recall when or exactly which Linux-related mailing list I
saw it on, but I saw a discussion on this topic, and people pointed out
that having the revision log in the git commit message actually has some
advantages; it documents some of the things that were though about during
the review, and ends up documenting which version of the patch actually
ended up in git.

Besides, it's a lot easier to maintain the changelog in the git commit
description than in some out-of-band location:-) Although I guess I
could edit the files after git format-patch.

So, I wonder if it might be a good idea to check the changelog in?

-- 
nvpublic

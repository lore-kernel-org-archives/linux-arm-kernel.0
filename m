From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 17:36:46 +0200
Subject: [GIT PULL] late omap mailbox clean-up, driver parts
In-Reply-To: <20140729113917.GP29045@atomide.com>
References: <20140729113917.GP29045@atomide.com>
Message-ID: <1420246.WMlB29KVsm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 04:39:18 Tony Lindgren wrote:
> The following changes since commit cbf14f3ab9bd6295b345fc812f08ddd844fb183e:
> 
>   ARM: AM33xx: hwmod_data: Remove legacy mailbox addrs (2014-07-15 05:08:56 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/mailbox-cleanup
> 
> for you to fetch changes up to 72c1c8179cdc5ba7208d375bd3f104659fc50ad0:
> 
>   mailbox/omap: add a parent structure for every IP instance (2014-07-29 01:57:25 -0700)
> 
> ----------------------------------------------------------------
> Driver specific omap mailbox cleanup. Mostly to remove
> broken legacy code for omap1 and move things towards
> device tree.
> 
> These patches were posted a while back, but I did not
> realize I was supposed to merge the driver related
> parts too. So apologies for a late pull request on
> these changes.

Ok, I see. I've merged them into next/drivers now, after first merging in the
first half of the series that we have in the next/soc branch.

	Arnd

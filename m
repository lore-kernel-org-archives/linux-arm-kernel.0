From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Nov 2011 21:15:40 +0000
Subject: [GIT PULL] omap fixes for v3.2-rc2
In-Reply-To: <20111119194408.GD31337@atomide.com>
References: <20111119194408.GD31337@atomide.com>
Message-ID: <201111232115.41035.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 November 2011, Tony Lindgren wrote:
> Please pull omap fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> 
> Most of this pull request are fixes needed by Tomi for the
> display driver clocking.
> 

Hi Tony,

Sorry for the delay on my side, I've only today looked at this series.
The patches all look ok, as far as I can tell, but please rebase
the series to make it easier to see what is going on:

* At least one of the sub-branches is based on a random commit on
  Linus' tree. Please always base patches on an -rc for consistency!

* Out of the 20 patches, not one is marked for 'stable' backports.
  I really want to make sure this time that all long-standing bugs
  get fixed in stable releases, so please go through the list and
  add 'Cc: stable at kernel.org' to the ones you want to have backported.
  If all patches are actually addressing regressions, just tell me
  in the introductory mail next time.

* Since a lot of patches address the dss, it would be nice to have
  a separate pull request for those. It's not really important, but
  I feel that it's easier to review stuff that is less mixed and
  splitting them out should be easy if you rebase the series anyway.

Thanks for your patience,

	Arnd

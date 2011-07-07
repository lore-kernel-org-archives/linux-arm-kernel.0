From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 22:40:58 +0200
Subject: [GIT PULL] omap board updates for v3.1 merge window
In-Reply-To: <20110707162911.GL5783@atomide.com>
References: <20110707162911.GL5783@atomide.com>
Message-ID: <201107072240.58987.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011 18:29:11 Tony Lindgren wrote:
> Please pull omap board updates from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board
> 
> These are currently on top of the fixes you pulled earlier but
> could be also rebased on the earlier cleanup if you prefer that.

I would generally prefer them to be independent, even if that causes
minor conflicts. If some branches are built on top of others, that
mainly means I have to remember the order in which to send them
upstream, and my memory for these things is limited.
 
> Please note that the board-cm-t35.c change will need a minor fix
> when merging with the atag_offset patch series. In MACHINE_START
> the .boot_params needs to be replaced with .atag_offset = 0x100.
>
> Also note that this series is missing the Nook Color board
> support as that one is waiting on the machine_id patch.

Ok

Thanks,

	Arnd

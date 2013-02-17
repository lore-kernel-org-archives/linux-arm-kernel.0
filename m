From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Feb 2013 18:00:58 -0500
Subject: [PATCH] ARM: Dove: fix build breakage with .timer/.init_time
In-Reply-To: <201302171823.44808.arnd@arndb.de>
References: <1361043816-28753-1-git-send-email-jason@lakedaemon.net>
 <201302171823.44808.arnd@arndb.de>
Message-ID: <20130217230058.GL23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Sun, Feb 17, 2013 at 06:23:44PM +0000, Arnd Bergmann wrote:
> On Saturday 16 February 2013, Jason Cooper wrote:
> > In the latest arm-soc/for-next, building dove_defconfig breaks because
> > .timer has been replaced with .init_timer in DT_MACHINE_START.  With
> > this fix, it builds fine.
...
> * if you don't want to rebase your branch, pull arm-soc/timer/cleanup
>   into it and do this change in the merge changeset, noting it down
>   in the changeset description. As above, when you send such a branch,
>   let us know of the dependency.

Done.  I'll send a follow-on pull request for mvebu/boards.  Thanks for
the clarification.

Jason.

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 17:20:53 +0200
Subject: [GIT PULL] ARM: mvebu: Last DT changes for v3.18
In-Reply-To: <20141002135926.GC27230@titan.lakedaemon.net>
References: <20141002135926.GC27230@titan.lakedaemon.net>
Message-ID: <1850328.rMhfjqiuR3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 October 2014 09:59:26 Jason Cooper wrote:
> 
> I know this is way late, but the changes a fairly small, and have been
> in linux-next for at least 9 of Stephen's 'next-YYYYMMDD' tags.
> Hopefully the merge window opening a week late will make it possible for
> you guys to take this.
> 
> This is an incremental pull request from tags/mvebu-dt-3.18 up to
> tags/mvebu-dt-3.18-2 on the mvebu/dt branch.

The one patch is a bug fix, so it's exempt from the deadline, the other
one is obviously harmless, so I'm pulling it into next/dt.

Regarding the DT change: Seriously? They made the same mistake
*AGAIN*? I hope that whoever at Marvell decided to change the
register location for a shipping product in a boot loader update
will lose their commit access.

	Arnd

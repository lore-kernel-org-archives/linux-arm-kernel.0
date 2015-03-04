From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 21:31:52 +0100
Subject: [GIT PULL] Renesas ARM Based SoC sh7372 SoC Removal Updates for
 v4.1
In-Reply-To: <cover.1424931560.git.horms+renesas@verge.net.au>
References: <cover.1424931560.git.horms+renesas@verge.net.au>
Message-ID: <3043216.AuL1ank19q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 February 2015 15:22:11 Simon Horman wrote:
> Renesas ARM Based SoC sh7372 SoC Removal Updates for v4.1
> 
> * Remove the sh7372 SoC and its mackerel board
> 

Pulled into next/cleanup.

I found the text a little short to justify a removal, but since I know
the story, I've extended the narrative a bit, I hope this text is
ok with you:

    [arnd: The sh7372 platform is rather dated and is believed to
     have no active users. It stands in the way of converting all
     of mach-shmobile to be multiplatform capable, as adding
     pinctrl and clock support for it would be more work than it's
     worth. As always, should any legitimate upstream users show up
     in the future, we will revert this removal]

It would be nice to have more text in the tag description for cases that
are not obvious to the reader, like this one.

	Arnd

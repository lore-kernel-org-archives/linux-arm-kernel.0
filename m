From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 27 Jul 2015 09:32:12 +1000
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
Message-ID: <20150727093212.6556dbcb@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Today's linux-next merge of the renesas tree got conflicts in:

  arch/arm/mach-shmobile/board-marzen-reference.c and
  arch/arm/mach-shmobile/board-marzen.c

between commit:

  3017a8804ada ("ARM: appropriate __init annotation for const data")

from the arm-soc tree and commits:

  d2fb6bdaffc7 ("ARM: shmobile: marzen-reference: Remove C board code")
  9d35777f2b96 ("ARM: shmobile: marzen: Remove legacy board code")

from the renesas tree.

I fixed it up (I just removed the 2 files) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

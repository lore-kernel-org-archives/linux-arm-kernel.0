From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sun, 1 Nov 2015 10:35:55 +1100
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20151101103555.2464c0ee@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in:

  arch/arm/mach-mvebu/pmsu.c

between commit:

  9d2ea95a599a ("ARM: mvebu: add broken-idle option")

from the arm-soc tree and commit:

  da6ee32a42c0 ("ARM: mvebu: add broken-idle option")

from the mvebu tree.

I fixed it up (looks like 2 version of the same thing (though different)
so I just used the version from the arm-doc tree) and can carry the fix
as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

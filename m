From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 05 Aug 2013 20:15:10 -0700 (PDT)
Subject: [PATCH 0/2] ARM: shmobile: remove nfsroot settings
In-Reply-To: <87pptrh6f3.wl%kuninori.morimoto.gx@renesas.com>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-4-git-send-email-horms+renesas@verge.net.au>
 <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
 <20130801080226.GF15265@verge.net.au>
 <20130806010736.GA20940@verge.net.au>
 <87r4e7h88z.wl%kuninori.morimoto.gx@renesas.com>
 <20130806022955.GA25114@verge.net.au>
 <87pptrh6f3.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87ob9bh5mt.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> Yes, I can send patches.
> But, I can't test emev2-kzm9d board.
> Do you have it ?

These patches remove nfsroot settings from kzm9d/armadillo dts file.
I tested #1 patch on Armadillo board, but I don't have kzm9d board.

Kuninori Morimoto (2):
      ARM: shmobile: armadillo800eva: remove nfsroot settings from bootargs
      ARM: shmobile: kzm9d: remove nfsroot settings from bootargs

 arch/arm/boot/dts/emev2-kzm9d-reference.dts        |    2 +-
 arch/arm/boot/dts/emev2-kzm9d.dts                  |    2 +-
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

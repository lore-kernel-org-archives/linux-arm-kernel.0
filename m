From: linux@baker-net.org.uk (Adam Baker)
Date: Sun, 06 Apr 2014 22:37:33 +0100
Subject: [PATCH 0/3] ARM: kirkwood: Add device tree for NSA320
Message-ID: <5341C91D.4060007@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As promised here are my sequence of patches to add support for the
Zyxel NSA 320

The three patches are as previously discussed

1 - Move some things that are common to both nsa310, nsa310a and nsa320 into
    kirkwood-nsa310-common.dtsi
2 - add the dts for nsa320
3 - rename kirkwood-nsa310-common.dtsi to kirkwood-nsa3x0-common.dtsi (I suspect
    the nsa325 is sufficiently different to not share this file). I suggest
    making this change last as it can easily be dropped till later if it causes
    conflicts.

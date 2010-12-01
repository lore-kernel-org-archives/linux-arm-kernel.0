From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 01 Dec 2010 09:37:15 +0100
Subject: [patch 0/2] iMX51 small fixes
Message-ID: <20101201083715.625363724@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi,

This series is containing 2 small patches for iMX5 SoC.

The first one is touching at the gpiolib support. Currently, it's always
returning 0 as gpio value when configured as output so I've modified it to
report what we asked. I've only tested it by looking at /sys/kernel/debug/gpio
so I've no idea if this can actively break something.

The second one is less interesting. It's "only" fixing a build failure so not
a lot of things to say.

I've tested them against Sascha's Hauer imx-for-2.6.38 branch but they do apply
on current mainline tree.

Arnaud

From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Dec 2013 14:37:26 -0500
Subject: [GIT PULL] ARM: mvebu: drivers changes for v3.14 (incr. #2)
Message-ID: <20131227193726.GE19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

After some discussion with the maintainer of drivers/rtc (Alessandro
Zummo), he's expressed a preference for patches to go through arch
trees due to his limited time.  Hence, we're taking this rtc driver
through mvebu/arm-soc.

As usual, it's been in -next for while, although, it's not enabled in
any defconfigs.  I've built it without warnings against mvebu_defconfig.

This pull is an incremental pull request from tags/mvebu-drivers-3.14 to
tags/mvebu-drivers-3.14-2 in the mvebu/drivers branch.

thx,

Jason.

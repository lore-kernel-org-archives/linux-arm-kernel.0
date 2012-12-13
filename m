From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Dec 2012 17:55:43 -0800
Subject: [GIT PULL 0/5] ARM: arm-soc: Second batch of pull requests
Message-ID: <20121213015543.GA18953@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is the second batch of arm-soc changes for this merge window.

The first two branches have a handful of conflicts:
- The DT branch is mostly due to add/add changes but also due to some
  include changes/cleanup.
- The multiplatform branch contains some dependent pinctrl patches that
  seem to have been rebased either on the branch we received, or at the
  pinctrl side. Unfortunately we didn't catch it when it happened. It
  doesn't cause a whole lot of problems this time, luckily. We'll be
  more diligent on this in the future.

As before, conflict resolution documented in each pull request, and
-resolved branches pushed up for reference.

After this, we have about another 4 branches queued up, and possibly a
few more straggling patches on top of those.


Thanks!

-Olof

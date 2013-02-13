From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 22:11:40 +0900
Subject: [PATCH 0/3 v2] ARM: mach-shmobile: defconfig REGULATOR settings
Message-ID: <1360761103-17357-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enable REGULATOR for mackerel and armadillo800eva as
  it will be needed for MMCIF to function.
* Do not enable REGULATOR_DUMMY for kzm9g,
  it is only intended to be used for development and testing.

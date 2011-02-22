From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Feb 2011 23:55:11 -0600
Subject: [PATCH v3 0/6] Tegra board patches
Message-ID: <1298354117-19097-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Third spin of board patches for .39. They have been tested on harmony
and seaboard.

Chances since v2:

* Fixed up a mismerge resulting in a bad sdhci patch for harmony
* Revised seaboard patch based on comments
* Synced up harmony pinmux and seaboard pinmux with runtime debugfs info

Changes since v1:

* I dropped the PCI-e patch since Mike is actively working on fixing
up that subsystem, and the reboot patch from Simon went in to Colin's
branch already.

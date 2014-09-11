From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Sep 2014 16:28:57 -0700
Subject: [GIT PULL 4/5] omap mailbox changes for v3.18 merge window
In-Reply-To: <pull-1410478051-378788>
References: <pull-1410478051-378788>
Message-ID: <pull-1410478051-378788-4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/mailbox-for-v3.18

for you to fetch changes up to 75288cc66dc478b32e43970dd6913396526504ae:

  mailbox/omap: add support for parsing dt devices (2014-09-11 11:39:14 -0700)

----------------------------------------------------------------
Mailbox related changes for omaps to get it to work with
device tree.

----------------------------------------------------------------
Suman Anna (2):
      Documentation: dt: add omap mailbox bindings
      mailbox/omap: add support for parsing dt devices

 .../devicetree/bindings/mailbox/omap-mailbox.txt   | 108 ++++++++++++++
 drivers/mailbox/omap-mailbox.c                     | 156 +++++++++++++++++----
 2 files changed, 240 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

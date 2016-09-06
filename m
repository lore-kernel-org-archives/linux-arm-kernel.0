From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 6 Sep 2016 21:50:12 +0530
Subject: [GIT PULL] Mailbox fixes for v4.8-rc
Message-ID: <CABb+yY09Kx+ymqZ9a0a6cN=x7eVwJK9si398cOFZM_wWA-PPcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 5e608a027082ae426e100a582031e0ff40becc83:

  Merge branch 'akpm' (patches from Andrew) (2016-08-26 23:12:12 -0700)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-devel

for you to fetch changes up to a75e4a85f49e7f5d71cf0e425bc009c15ad3b5c4:

  fix:mailbox:bcm-pdc-mailbox:mark symbols static where possible
(2016-08-29 18:43:39 +0530)

----------------------------------------------------------------
* Misc fixes for BCM mailbox driver
     Fix build warnings by making static functions used within the file.
     Check for potential NULL before dereferencing
     Fix link error by defining HAS_DMA dependency

----------------------------------------------------------------
Baoyou Xie (1):
      fix:mailbox:bcm-pdc-mailbox:mark symbols static where possible

Dan Carpenter (1):
      mailbox: bcm-pdc: potential NULL dereference in pdc_shutdown()

Rob Rice (1):
      mailbox: Add HAS_DMA Kconfig dependency to BCM_PDC_MBOX

 drivers/mailbox/Kconfig           |  1 +
 drivers/mailbox/bcm-pdc-mailbox.c | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 26 Nov 2013 16:44:08 +0900
Subject: [GIT PULL] extcon fixes for 3.13-rc2
Message-ID: <52945148.2020205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

This is extcon fixes pull request for 3.13-rc2. I add detailed description of
this pull request on below. Please pull extcon fixes with following updates.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-linus-for-3.13-rc2

for you to fetch changes up to 7585ca0dc950583be7fc62099ca43a0c9551a875:

  extcon: remove freed groups caused the panic or warning in unregister flow (2013-11-26 15:17:23 +0900)

----------------------------------------------------------------
Update extcon for 3.13-rc2

This patchset fix NULL pointer error of extcon-arizona driver and fix issue
about memory of device groups when calling extcon_dev_unregister function.

----------------------------------------------------------------
Charles Keepax (1):
      extcon: arizona: Get pdata from arizona structure not device

Wang, Xiaoming (1):
      extcon: remove freed groups caused the panic or warning in unregister flow

 drivers/extcon/extcon-arizona.c | 4 +---
 drivers/extcon/extcon-class.c   | 3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

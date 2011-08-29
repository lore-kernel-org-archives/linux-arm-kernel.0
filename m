From: per.forlin@linaro.org (Per Forlin)
Date: Mon, 29 Aug 2011 15:35:57 +0200
Subject: [PATCH 0/2] mmc: clarifications on host.post_req()
Message-ID: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes for 3.1.
This patchset doesn't fix any bugs in 3.1 but it improves the documentation
in order to prevent new bugs.

Per Forlin (2):
  mmc: core: clarify how to use post_req in case of errors
  mmc: mmci: simplify err check in mmci_post_request

 drivers/mmc/core/core.c  |    6 ++++++
 drivers/mmc/host/mmci.c  |    2 +-
 include/linux/mmc/host.h |    3 +++
 3 files changed, 10 insertions(+), 1 deletions(-)

-- 
1.7.4.1

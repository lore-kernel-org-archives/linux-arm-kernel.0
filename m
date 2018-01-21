From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 21 Jan 2018 16:02:37 -0600
Subject: [GIT PULL] Qualcomm Fixes for 4.16
Message-ID: <1516572157-968-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd/Olof/Kevin,

Please take this fix for 4.16.  This applies on top of the current next
(next-20190119).

Thanks,

Andy

The following changes since commit 761914dd2975bc443024f0ec10a66a26b7186ec2:

  Add linux-next specific files for 20180119 (2018-01-19 17:51:17 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-4.16

for you to fetch changes up to a218c67e4eb95287129b56c20a94b9ea0d8917e5:

  of: platform: fix OF node refcount leak (2018-01-21 15:01:34 -0600)

----------------------------------------------------------------
Qualcomm Fixes for 4.16

* Fix OF node refcount leak

----------------------------------------------------------------
Sudeep Holla (1):
      of: platform: fix OF node refcount leak

 drivers/of/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

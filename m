From: mturquette@linaro.org (Mike Turquette)
Date: Tue,  4 Dec 2012 13:00:21 -0800
Subject: [PATCH 0/2] clk: misc bits for 3.8
Message-ID: <1354654823-1576-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Unless there are any objections I plan to add these patches to the
clk-next queue for 3.8.  If there is discussion of the first patch then
I'll hold off until it's ready.

Thanks,
Mike

Mike Turquette (2):
  clk: introduce optional disable_unused callback
  MAINTAINERS: bad email address for Mike Turquette

 MAINTAINERS                  |    1 -
 drivers/clk/clk.c            |   13 +++++++++++--
 include/linux/clk-provider.h |    6 ++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.7.9.5

From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 20 Dec 2013 10:33:02 +0100
Subject: [GIT PULL] clk: ux500 updates for 3.14, take 1
Message-ID: <CAPDyKFpwUrhtT3840EtVRJVbvzM2zvL54gd+xZ4n95bdy+EWUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

This is a collection of patches for the ux500 clk driver for 3.14.

Actually there is only one minimalistic patch included here, but I
though it could be a good practice since this is the first pull
request I send you.

Kind regards
Ulf Hansson


The following changes since commit 1459c837036a44e2dcf14a9452ed330201fb23b5:

  clk: si570: Add a driver for SI570 oscillators (2013-12-14 21:01:35 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ulfh/clk.git clk-next-ux500

for you to fetch changes up to ea8776da4d28dbf2c096076db819dfc7d0a7ad40:

  clk: ux500: Remove extra semicolon (2013-12-19 21:45:51 +0100)

----------------------------------------------------------------
Sachin Kamat (1):
      clk: ux500: Remove extra semicolon

 drivers/clk/ux500/clk-prcmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

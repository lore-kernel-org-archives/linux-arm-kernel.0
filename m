From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 28 Sep 2012 13:21:03 +0200
Subject: [PATCH 0/3] Fixup use of runtime pm
Message-ID: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Some old runtime pm patches got merged whiched messed up things.
These is now reverted. Additionaly one patch do a simplification
of the use of runtime pm functions.

Ulf Hansson (3):
  Revert "spi/pl022: fix spi-pl022 pm enable at probe"
  Revert "spi/pl022: enable runtime PM"
  spi: spi-pl022: Minor simplification for runtime pm

 drivers/spi/spi-pl022.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
1.7.10

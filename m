From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 4 Oct 2012 10:04:38 +0200
Subject: [PATCH V2 0/3] spi: spi-pl022: Fixup use of runtime pm
Message-ID: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Some old runtime pm patches got merged whiched messed up things.
These are now reverted. Additionaly one patch do a simplification
of the use of runtime pm functions.

V2:
Rebased patches and updated commit messages.

Ulf Hansson (3):
  Revert "spi/pl022: fix spi-pl022 pm enable at probe"
  Revert "spi/pl022: enable runtime PM"
  spi: spi-pl022: Minor simplification for runtime pm

 drivers/spi/spi-pl022.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
1.7.10

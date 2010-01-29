From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:11 +0000
Subject: Eliminate plat-s3c
Message-ID: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series eliminates plat-s3c from the build, as it can mostly
be moved into plat-samsung and plat-s3c24xx.

May end up squashing the series down a bit.

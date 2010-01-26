From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:02:51 +0000
Subject: S3C6410/S3C6400 platform squash
Message-ID: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attached is the series to squash mach-s3c6400 and mach-s3c6410 together
and then also place plat-sc64xx in there as well (mostly).

The only issue is we are left with two files in plat-s3c64xx which are
required from include/plat. Would adding an include/plat directory to
arch/arm/mach-s3c64xx be ok for these or do we need to find another
solution?

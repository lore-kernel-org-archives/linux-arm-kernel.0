From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 23 Oct 2012 23:48:21 +0900
Subject: ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined
Message-ID: <022101cdb12d$724e9650$56ebc2f0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Now, v3.7-rc2 happens following build error with s3c2410_defconfig...

ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make[1]: *** Waiting for unfinished jobs....

Any idea on this?

Thanks.

K-Gene <kgene@kernel.org>

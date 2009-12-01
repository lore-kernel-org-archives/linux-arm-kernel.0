From: ben-linux@fluff.org (Ben Dooks)
Date: Tue,  1 Dec 2009 01:43:06 +0000
Subject: Samsung clock changes
Message-ID: <1259631793-25480-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial run of clock changes, only tested past the 'they build'
stage. If someone else can test and report success then that
would be helpful.

git branch next-samsung-clock will get you these plus most of
the other s3c64xx and s3c24xx changes since 2.6.32-rc7.

As such the s5pc1xx code has only be touched as far as fixing
the merge problems with the update 'clk_ops' code and has yet
to have the common clksrc code patches applied to it.

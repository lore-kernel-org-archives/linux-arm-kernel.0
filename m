From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2010 17:03:49 +0000
Subject: Uncompressing broken with commit e7db7b4270
Message-ID: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For whatever reason, with commit e7db7b4270 (arm: add support for
LZO-compressed kernels) if the kernel Image goes beyond a certain size
it fails to uncompress. Reverting this commit solves the problem.
Removing some random kernel features also solves the uncompressing as
the kernel image gets smaller.

Any idea?

-- 
Catalin

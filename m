From: narkewoody@gmail.com (Woody Wu)
Date: Fri, 16 Nov 2012 17:19:08 +0000 (UTC)
Subject: s3c2410 (Linux 2.6.36) Incorrect DRAM size
Message-ID: <slrnkactau.29u.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

I just buit a 2.6.36 and boot it from a s3c2410 board.  At the very
beginning of consol log, the kernel reports the DRAM size if 16M.
(Memory: 16M = 16M total).  But the board actually has 64M ram in two
bands (each is 32M).

Did someone know the cause and have a hint or solution? And, does anyone
knows that the DRAM size is auto-detected by kernel or hard configured
in some .h?

Thanks in advance

-- 
-woody
I can't go back to yesterday - because I was a different person then.

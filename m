From: narkewoody@gmail.com (Woody Wu)
Date: Fri, 16 Nov 2012 02:44:20 +0000 (UTC)
Subject: Incorrect RAM memory size
Message-ID: <slrnkaba55.270.narkewoody@CNZUHNB705.adhoc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In general, I want to know how the ram memory size is determined by the
kernel. The relevant kernel log info is something like: "Memory: xxMB =
xxMB total".

In my s3c2410 board, it has 64MB, but the kernel reports only 16MB. The
kernel version is 2.6.36.

Is there any configuration file I should go modify to tell the kernel or
that's is automatically detected at kernel initialization phase?

Thanks in advance.

-- 
-woody
I can't go back to yesterday - because I was a different person then.

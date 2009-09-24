From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 24 Sep 2009 17:32:37 +0200
Subject: S3C6410 SDHCI driver crash
Message-ID: <4ABB9115.4030609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm currently experiencing an SDHCI bug in 2.6.31 and linux-next, which 
didn't
seem to appear in 2.6.31-rc8.

This is on a new S3C6410 platform (SmartQ 7, see [1]) and it seems to be
consistently happening right after displaying "Loading hardware drivers" (in
user-space; Ubuntu-based).

The relevant kernel log lines are:

blk: request botched
kernel BUG at drivers/mmc/host/sdhci.c:298!

This is on 2.6.31-next-20090923, but I've also had this on regular 
2.6.31, Ben
Dooks latest tree and linux-next with the ADMA patches applied.

Any ideas?

[1] 
http://gitorious.org/mcuelenaere-smartq-kernel/mcuelenaere-smartq-kernel/commits/experimental-2.6.31

Regards,

Maurus Cuelenaere

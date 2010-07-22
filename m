From: lmctlx@gmail.com (Karol)
Date: Thu, 22 Jul 2010 14:44:54 +0000 (UTC)
Subject: GCOV on arm - no files but /debug/reset
Message-ID: <i29lh6$bh5$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying to use GCOV profiling on ARM architecture without much
success.

I've enabled CONFIG_GCOV=y in .config and added "GCOV_PROFILE := y" to
bunch of Makefiles (in kernel/, fs/, etc.).   According to the docs
(Documentation/gcov.txt) debugfs should be automatically populated
with profile files along with symlinks to sources. However, my
<debugfs>/gcov directory is empty.

I've tested old LTP's gcov patches (to kernel 2.6.25, I think) and it
worked as expected.

Am I missing something obvious?  Hints?

Thanks in advance.

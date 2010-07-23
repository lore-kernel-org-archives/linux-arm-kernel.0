From: lmctlx@gmail.com (Karol)
Date: Fri, 23 Jul 2010 07:46:33 +0000 (UTC)
Subject: GCOV on arm - no files but /debug/reset
References: <i29lh6$bh5$1@dough.gmane.org>
Message-ID: <i2bhcp$q4f$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jul 2010 14:44:54 +0000, Karol wrote:
> I've enabled CONFIG_GCOV=y in .config and added "GCOV_PROFILE := y" to
> bunch of Makefiles (in kernel/, fs/, etc.).   According to the docs
> (Documentation/gcov.txt) debugfs should be automatically populated with
> profile files along with symlinks to sources. However, my <debugfs>/gcov
> directory is empty.

Ok, it's almost empty - it contain only "reset" file.

I should add that I'm using 2.6.35-rc3 kernel.

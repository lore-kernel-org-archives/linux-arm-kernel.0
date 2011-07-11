From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Jul 2011 01:32:26 -0700
Subject: [GIT PULL] OMAP: SoC data/core: cleanups for 3.1
In-Reply-To: <alpine.DEB.2.00.1107092031400.15984@utopia.booyaka.com>
References: <alpine.DEB.2.00.1107092031400.15984@utopia.booyaka.com>
Message-ID: <20110711083225.GO5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110709 19:32]:
> Hello Tony,
> 
> The following changes since commit ecba3287b4121dcf3ca7607fe71c205913edec06:
> 
>   Merge branch 'cleanup-part-2' of git+ssh://master.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6 into omap/cleanup (2011-07-08 15:01:45 +0000)
> 
> are available in the git repository at:
> 
>   git://git.pwsan.com/linux-2.6 prcm-cleanup-3.1

I've merged this into linux-omap master for testing and
also merged it into cleanup-part-3 along Russell's timer
cleanup patch.

Paul, please use the mainline tags or linux-omap static branches
instead of the arm-soc branches. In this case there's only the extra
merge commit there, so not a problem. Now it just makes it a bit
harder for me to do pull requests and diffs to other branches.

In general, we want to keep the dependencies between branches and
other trees to minimum.

Regards,

Tony

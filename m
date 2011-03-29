From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Mar 2011 10:16:59 -0700
Subject: [PATCH 05/10] omap2+: Use dmtimer macros for clockevent
In-Reply-To: <20110328222140.4046.91213.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222140.4046.91213.stgit@baageli.muru.com>
Message-ID: <20110329171659.GJ4016@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110328 15:19]:
> 
> Note that omap_dmtimer_init_one can eventually be moved to
> omap2+ specific dmtimer.c.

Actually after this series we'll have just timer.c, will
remove this comment.

Tony

From: tony@atomide.com (Tony Lindgren)
Date: Sat, 16 Jan 2010 12:15:13 -0800
Subject: [PATCH 0/4] omap multiboot improvments for merge window after
	2.6.34
In-Reply-To: <20100116013205.10065.95921.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
Message-ID: <20100116201513.GN10318@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100115 17:32]:
> Hi all,
> 
> Here are some multiboot improvments for review. These patches
> are intended for the 2.6.34 merge window.
> 
> Comments and testing would be nice, I've tested them so far
> on osk, 770, n800, rx51 and overo.

Attached is also an experimental patch to compile in 2420 and 34xx
and the .config I used.

It still fails early during the boot in dmtimer_init, so it's
just for reference in case anybody wants to play with it.

Note that we still have a problem compiling in 2420 and 2430
because of the different clock bases.

Cheers,

Tony

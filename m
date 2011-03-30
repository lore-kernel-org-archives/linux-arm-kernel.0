From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 30 Mar 2011 11:08:07 +0200 (CEST)
Subject: [PATCH] arm: fix build failure introduced by typo in irq namespace
	cleanup.
In-Reply-To: <20110330060229.27397.7628.stgit@ponder>
References: <20110330060229.27397.7628.stgit@ponder>
Message-ID: <alpine.LFD.2.00.1103301107020.22418@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Mar 2011, Grant Likely wrote:

> Commit 6845664a6a7d443f03883db59d10749d38d98b8e, "arm: Cleanup the irq
> namespace" introduces a typo causing a build failure for the versatile
> platform.

Sorry about that. I have no clue how I fatfingered that in last
minute.

rmk: are you picking it up or should I push it linuswards with the
other fixups ?
 
Thanks,

	tglx

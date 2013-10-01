From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 12:49:45 -0400
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131001164556.GA23874@obsidianresearch.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost> <524AD2F7.4090803@gmail.com>
 <20131001142205.GF2448@localhost> <524ADFAA.40805@gmail.com>
 <20131001164556.GA23874@obsidianresearch.com>
Message-ID: <20131001164945.GE31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 10:45:56AM -0600, Jason Gunthorpe wrote:
...
> BTW, why doesn't CONFIG_ARM_ATAG_DTB_COMPAT fix this? Do the boot
> loaders on these systems not pass the mac at all??

Because the ATAGs used were never approved.  The vendors just randomly
picked their own.

thx,

Jason.

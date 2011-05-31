From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 May 2011 15:03:57 +0100
Subject: [PATCH 1/3] plat-nomadik: MTU sched_clock as an option
In-Reply-To: <1306830623-9504-1-git-send-email-mattias.wallin@stericsson.com>
References: <1306830623-9504-1-git-send-email-mattias.wallin@stericsson.com>
Message-ID: <20110531140357.GD21382@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 10:30:23AM +0200, Mattias Wallin wrote:
> This patch makes it possible to configure away the sched_clock
> part of the MTU timer.

We really need better changelogs than this.  Rather than saying just what
the patch is doing, please also say _why_ the change is required - you
can't expect people reading the patch to guess that kind of thing.

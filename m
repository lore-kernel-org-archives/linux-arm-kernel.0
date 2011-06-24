From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Jun 2011 08:55:23 +0100
Subject: [PATCH] OMAP3: PM: remove get_*_restore_pointer functions,
	directly use entry points
In-Reply-To: <1308874574-30663-1-git-send-email-khilman@ti.com>
References: <1308874574-30663-1-git-send-email-khilman@ti.com>
Message-ID: <20110624075523.GJ9449@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2011 at 05:16:14PM -0700, Kevin Hilman wrote:
> Applies on top of Russell's suspend cleanup/rejig, and available
> (along with Russell's series) in my pm-wip/idle-suspend branch.
> 
> Russell, since it depends on your series, feel free to add it to your
> series if you like.  Or if you prefer, we can take it through the OMAP
> tree.

Thanks, I've picked it up, and changed the prefix on the subject line
to match the rest of my series.  Also cleaned up the trailing tabs
and added Santosh's ack.

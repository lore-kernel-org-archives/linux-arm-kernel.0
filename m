From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Mar 2014 22:08:38 -0500
Subject: [PATCH V2] ARM: dove: dt: revert PMU interrupt controller node
In-Reply-To: <20140303222406.GW1872@titan.lakedaemon.net>
References: <20140207180836.GE8533@titan.lakedaemon.net>
 <1392667236-19126-1-git-send-email-jason@lakedaemon.net>
 <20140303150215.GI21483@n2100.arm.linux.org.uk>
 <20140303173740.GC16655@lunn.ch>
 <20140303181529.GM21483@n2100.arm.linux.org.uk>
 <20140303222406.GW1872@titan.lakedaemon.net>
Message-ID: <20140304030838.GA1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 05:24:06PM -0500, Jason Cooper wrote:
> I've no issue with reverting this driver.  I'll ask arm-soc to hold off
> on pulling the latest mvebu DT pull request which contains the DT node.
> I _really_ don't want to do a revert of a revert of a revert. :-/

Done.  I'll work on reverting the driver tomorrow.  It's currently in
tip/irq/core queued for v3.15.

thx,

Jason.

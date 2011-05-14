From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 May 2011 11:26:40 +0100
Subject: [PATCH] shmobile: fix map_io init usage
In-Reply-To: <20110513015653.GM18952@game.jcrosoft.org>
References: <1304267322-19022-1-git-send-email-plagnioj@jcrosoft.com>
	<20110513015653.GM18952@game.jcrosoft.org>
Message-ID: <20110514102640.GD30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 03:56:53AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:28 Sun 01 May     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > switch early init to init_early and introduce soc map_io
> > 
> > with this Patch we will not do any more early device setup during the map io
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> ping

Ultimately up to Paul and Magnus, but from my POV, it looks fine to me.

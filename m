From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Sep 2012 23:32:21 +0100
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <5058F35A.8040702@firmworks.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
 <20120915001431.GB12445@n2100.arm.linux.org.uk>
 <201209172042.11860.arnd@arndb.de> <5058F35A.8040702@firmworks.com>
Message-ID: <20120918223221.GG12445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 06:19:06AM +0800, Mitch Bradley wrote:
> Is there ever a point when old architectures leave the Linux tree, or
> will people have to see grep hits from them until the end of time?

That depends on use and the burden of keeping them in the tree.  I'm
not aware of much activity around Shark, and I'm not aware of Shark
causing that many problems either...

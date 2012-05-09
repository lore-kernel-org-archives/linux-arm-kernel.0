From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 May 2012 17:27:50 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205091626.27829.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205091243.13206.arnd@arndb.de>
 <20120509160747.GA10241@n2100.arm.linux.org.uk>
 <201205091626.27829.arnd@arndb.de>
Message-ID: <20120509162750.GD10241@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 04:26:27PM +0000, Arnd Bergmann wrote:
> On Wednesday 09 May 2012, Russell King - ARM Linux wrote:
> > Do we care about making them appear in procfs?  I suspect at this stage
> > that would be wrong.  If we care at all, they should probably be per-
> > top-level-device sysfs files - and we should have a function which sysfs
> > can use along with the root resource to create that output.
> 
> If the resources have separate roots, I see no way how to make them
> all appear in the same procfs file. Having them represented in sysfs
> the way you describe sounds useful but not important.

I'd agree with that.  I included that statement as food for thought if
someone _did_ want this.

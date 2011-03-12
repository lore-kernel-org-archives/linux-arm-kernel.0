From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Mar 2011 01:05:50 +0100
Subject: [PATCH 4/8] ARM: PXA: Z2: Add mtd partition with logo
In-Reply-To: <201103120031.28301.anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103112239.36682.marek.vasut@gmail.com>
	<201103120031.28301.anarsoul@gmail.com>
Message-ID: <201103120105.50159.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 23:31:28 Vasily Khoruzhick wrote:
> On Friday 11 March 2011 23:39:36 Marek Vasut wrote:
> > On Friday 11 March 2011 11:23:39 Vasily Khoruzhick wrote:
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > 
> > I guess you can rather supply the MTD layout on kernel command line (see
> > Drivers/MTD).
> 
> Yeah, I know, just want to make default layout look like this.

Why not like what's already there ? I don't see any point in changing this, NAK, 
use command line partitioning.

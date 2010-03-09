From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 9 Mar 2010 20:15:22 +0100
Subject: [CFT:PATCH] Remove a seemingly unnecessary cache flush
In-Reply-To: <20100309172045.GD17251@n2100.arm.linux.org.uk>
References: <20091207221210.GI26821@n2100.arm.linux.org.uk>
	<19350.28003.131508.958162@pilspetsen.it.uu.se>
	<20100309172045.GD17251@n2100.arm.linux.org.uk>
Message-ID: <19350.40522.439666.173257@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Tue, Mar 09, 2010 at 04:46:43PM +0100, Mikael Pettersson wrote:
 > > What's the status of this patch? I see that it's still not included
 > > in the 2.6.34-rc1 kernel. Did it turn out to be invalid, or was it
 > > just forgotten?
 > 
 > I was hoping for some tested-by lines before including it, as I
 > requested on the 18th December.

These report successful tests, but only one (mine) includes a
proper Tested-by line:

http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/006473.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/006048.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005663.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005855.html

Anyway, I'm happy to hear that the patch is still valid, so I'll
continue to apply it locally until it gets merged upstream.

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 May 2015 21:57:08 +0200
Subject: [PATCHv2 2/3] bus: mvebu-mbus: use automatic I/O
 synchronization barriers
In-Reply-To: <20150528194333.GA1468@aspire-one.musicnaut.iki.fi>
References: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1421424689-5971-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <5530E44E.8070105@freebox.fr>
 <20150528194333.GA1468@aspire-one.musicnaut.iki.fi>
Message-ID: <20150528215708.03cb616f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Aaro Koskinen,

On Thu, 28 May 2015 22:43:33 +0300, Aaro Koskinen wrote:

> On Fri, Apr 17, 2015 at 12:45:34PM +0200, Nicolas Schichan wrote:
> > On 01/16/2015 05:11 PM, Thomas Petazzoni wrote:
> > > Instead of using explicit I/O synchronization barriers shoehorned
> > > inside the streaming DMA mappings API (in
> > > arch/arm/mach-mvebu/coherency.c), we are switching to use automatic
> > > I/O synchronization barrier.
> > 
> > Hello Thomas,
> > 
> > I'm affraid this patche causes issue on mv88f6282 (and most probably on
> > mv88f6281 as well): see below.
> 
> Is this issue already fixed in 4.1-rc5?

No. I just resent the patch from Nicolas earlier today, he has been
merged by one of the mvebu maintainer, and he will send a pull request
for it. So it should be part of the final 4.1, and the patch is also
marked for stable, so it will be backported to 4.0.x as well.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

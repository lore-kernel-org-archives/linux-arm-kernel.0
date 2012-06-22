From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Jun 2012 01:08:57 -0700
Subject: N800 MMC broken on v3.5-rc3
In-Reply-To: <alpine.DEB.2.00.1206211307120.10198@utopia.booyaka.com>
References: <alpine.DEB.2.00.1206211216590.10198@utopia.booyaka.com>
 <alpine.DEB.2.00.1206211307120.10198@utopia.booyaka.com>
Message-ID: <20120622080857.GX12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120621 12:12]:
> On Thu, 21 Jun 2012, Paul Walmsley wrote:
> 
> > 
> > N800 no longer mounts MMC on v3.5-rc3:
> > 
> > http://www.pwsan.com/omap/bootlogs/20120620/omap_cleanup_a_3.6__07b3a13957aa250ff5b5409b8ed756b113544112/n800_bootlog.txt
> > 
> > This broke at some point between v3.4-rc2 and v3.5-rc3.
> 
> Hmm looks like Tony has some fixes for this that will hopefully resolve 
> this problem as of -rc4.

Yes works now, those are already in mainline since last week.

Tony

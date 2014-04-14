From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Apr 2014 15:24:50 +0200
Subject: [PATCH 3/5] ARM: EXYNOS5420: Add IO mapping for non-secure SYSRAM
In-Reply-To: <20140414115910.GD3844@e103592.cambridge.arm.com>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <11327275.EJLfDGG21r@wuerfel>
 <20140414115910.GD3844@e103592.cambridge.arm.com>
Message-ID: <5167415.PAy87EVlKC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 April 2014 12:59:11 Dave Martin wrote:
> On Mon, Apr 14, 2014 at 01:47:56PM +0200, Arnd Bergmann wrote:
> > On Monday 14 April 2014 12:25:20 Dave Martin wrote:
> > > Arnd, what was your preferred solution?  Should this be described in DT?
> > 
> > Yes. There are already patches on the list to do this right.
> 
> This is http://www.spinics.net/lists/linux-samsung-soc/msg27647.html,
> right?
> 
> If so, it looks like exynos5420 should definitely follow the same
> approach.
> 

Yes, exactly.

	Arnd

From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 28 Sep 2010 14:13:33 +0200
Subject: [PATCH 0/4] Updata S5PC110 GONI board
In-Reply-To: <007f01cb5f05$b1019fe0$1304dfa0$%kim@samsung.com>
References: <4C6CF047.7080507@samsung.com>
	<007f01cb5f05$b1019fe0$1304dfa0$%kim@samsung.com>
Message-ID: <006e01cb5f06$95a45b10$c0ed1130$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, September 28, 2010 2:07 PM Kukjin Kim wrote:

> > This patchset is to update GONi board.
> > Kyungmin sent partial one of this patchset but this is more updated
> > version.
> >
> > Thanks.
> >
> >
> > Joonyoung Shim (2):
> >        ARM: S5PC110: Add keypad device to the GONI board
> >        ARM: S5PC110: Add si470x radio device to the GONI board
> >
> 
> Could you please re-send following two patches?
> - keypad device patch already has been merged in my tree.
> - si470x radio patch has been included in Marek's patches
> 
> And I think need to update handling of gpio_request returning in the TSP
> patch.

TSP patch has been also included in my patch series with gpio-interrupts
(it is the last one).

> 
> > Kyungmin Park (2):
> >        ARM: S5PC110: GONI: Add TSP driver
> >        ARM: S5PC110: GONI: Fixed voltage support for eMMC


Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

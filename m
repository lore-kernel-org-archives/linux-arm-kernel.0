From: marex@denx.de (Marek Vasut)
Date: Fri, 5 Apr 2013 16:11:14 +0200
Subject: [PATCH] ARM: dts: imx23-olinuxino: Set the sdcard as non-removable
In-Reply-To: <20130405091656.GD2667@S2101-09.ap.freescale.net>
References: <1365135413-31493-1-git-send-email-aletes.xgr@gmail.com>
 <20130405091656.GD2667@S2101-09.ap.freescale.net>
Message-ID: <201304051611.15003.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Fri, Apr 05, 2013 at 01:16:53AM -0300, Alexandre Pereira da Silva wrote:
> > The imx23-olinuxino sdcard doesn't support card detect.
> 
> So it sounds more like a "broken-cd" rather than "non-removable"?

The CD line is working perfectly well on this board, so I don't get it.

Best regards,
Marek Vasut

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 10:07:20 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Replace
 CONFIG_USB_ISP1760_HCD by CONFIG_USB_ISP1760
In-Reply-To: <20150528003903.GB9384@verge.net.au>
References: <1432637918-8946-1-git-send-email-geert+renesas@glider.be>
 <20150528003903.GB9384@verge.net.au>
Message-ID: <2413647.WLsQ0T21gS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 May 2015 09:39:08 Simon Horman wrote:
> On Tue, May 26, 2015 at 12:58:37PM +0200, Geert Uytterhoeven wrote:
> > Since commit 100832abf065bc18 ("usb: isp1760: Make HCD support
> > optional"), CONFIG_USB_ISP1760_HCD is automatically selected when
> > needed.  Enabling that option in the defconfig is now a no-op, and no
> > longer enables ISP1760 HCD support.
> > 
> > Re-enable the ISP1760 driver in the defconfig by enabling
> > USB_ISP1760_HOST_ROLE instead.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks, I have queued this up for v4.3.
> 
> I would not object at all if the ARM SoC maintainers wish to
> take this earlier and I'd be happy to prepare a pull request
> to that effect once the change has sat in next. Unfortunately
> I anticipate that will be after the standard rc6 deadline.

I would consider patch 1 as a bug-fix, and put that into 4.1 or
4.2, depending on timing. Patch 2 looks like 4.3 material.

	Arnd 

From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 May 2015 09:39:08 +0900
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Replace
 CONFIG_USB_ISP1760_HCD by CONFIG_USB_ISP1760
In-Reply-To: <1432637918-8946-1-git-send-email-geert+renesas@glider.be>
References: <1432637918-8946-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150528003903.GB9384@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 12:58:37PM +0200, Geert Uytterhoeven wrote:
> Since commit 100832abf065bc18 ("usb: isp1760: Make HCD support
> optional"), CONFIG_USB_ISP1760_HCD is automatically selected when
> needed.  Enabling that option in the defconfig is now a no-op, and no
> longer enables ISP1760 HCD support.
> 
> Re-enable the ISP1760 driver in the defconfig by enabling
> USB_ISP1760_HOST_ROLE instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.3.

I would not object at all if the ARM SoC maintainers wish to
take this earlier and I'd be happy to prepare a pull request
to that effect once the change has sat in next. Unfortunately
I anticipate that will be after the standard rc6 deadline.

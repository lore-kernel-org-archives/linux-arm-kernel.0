From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 19 Oct 2013 14:19:12 -0700
Subject: [PATCH 2/2 v4] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <Pine.LNX.4.44L0.1310171710240.2436-100000@iolanthe.rowland.org>
References: <201310171329.12434.hartleys@visionengravers.com>
 <Pine.LNX.4.44L0.1310171710240.2436-100000@iolanthe.rowland.org>
Message-ID: <20131019211912.GB4453@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:11:54PM -0400, Alan Stern wrote:
> On Thu, 17 Oct 2013, H Hartley Sweeten wrote:
> 
> > Convert ep93xx to use the OHCI platform driver and remove the
> > ohci-ep93xx bus glue driver.
> > 
> > Enable CONFIG_OHCI_HCD_PLATFORM in the ep93xx_defconfig so that USB
> > is still enabled by default on the EP93xx platform.
> > 
> > Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Ryan Mallon <rmallon@gmail.com>
> > Cc: Lennert Buytenhek <kernel@wantstofly.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> Good work; thanks a lot for doing this.
> 
> Greg, please merge both of these v4 patches.

Will do, thanks for reviewing them.

greg k-h

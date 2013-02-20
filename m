From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 20 Feb 2013 10:28:52 -0800
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <20130219072438.GQ20212@lunn.ch>
References: <1360966349-1242560-2-git-send-email-arnd@arndb.de>
 <Pine.LNX.4.44L0.1302181723540.6790-100000@netrider.rowland.org>
 <20130219072438.GQ20212@lunn.ch>
Message-ID: <20130220182852.GA11327@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 08:24:38AM +0100, Andrew Lunn wrote:
> 
> GregKH: Please can you drop this patch from usb-next. It breaks more
> than it fixes.

I've now reverted both of these, and the follow-on patch that Arnd sent
in.

Arnd, sorry, but please be more careful, especially when you ask for
patches to be rushed into the tree...

greg k-h

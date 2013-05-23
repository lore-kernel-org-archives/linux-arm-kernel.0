From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 19:42:18 +0200
Subject: [RFC V6 PATCH 3/3] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1305231335531.925-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1305231335531.925-100000@iolanthe.rowland.org>
Message-ID: <201305231942.19172.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Alan Stern wrote:
> > > 
> > 
> > This section of the driver is gone now since 86510bb248 "USB: OHCI: 
> > clarify Kconfig dependencies", so the change is no longer needed.
> 
> I don't know what tree you're referring to.  That commit is not present
> in Greg's usb-linus or usb-next branches.  The usb-next branch is what 
> I use for new development.

Sorry, my mistake. I had looked at a temporary tree based on linux-next,
and I thought that Greg had applied my patch and put it into usb-next,
but instead it's a patch I had sitting on the branch I used for build
testing. I have not yet submitted that one again, and I'm sure that
Manjunath doesn't have it on his machine, so your comment still applies.

	Arnd

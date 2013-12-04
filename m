From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 4 Dec 2013 10:21:51 -0500 (EST)
Subject: [PATCH 3/3] usb: ohci-at91: use device managed clk retrieval
In-Reply-To: <529EE8A5.7010806@overkiz.com>
Message-ID: <Pine.LNX.4.44L0.1312041021120.1329-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Dec 2013, boris brezillon wrote:

> > The patches look fine to me.  But only the 1/3 patch fixes a bug; the
> > others merely change the resource management.
> 
> Do you want me to split this series ?
>   1) the 1st patch that should be merged in 3.13
>   2) patches 2 to 4 that might be applied later

That probably would make Greg happier.

Alan Stern

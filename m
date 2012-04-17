From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 17 Apr 2012 10:24:12 -0400 (EDT)
Subject: [PATCH 11/12] USB: ohci-at91: change annotations for probe/remove
 functions
In-Reply-To: <4F8D64F5.5060300@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1204171022550.1364-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Apr 2012, Nicolas Ferre wrote:

> On 04/16/2012 11:20 AM, Nicolas Ferre :
> > Add __devinit and __devexit on *_probe() and *_remove() functions
> > with proper modification of struct platform_driver.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> 
> Alan,
> 
> Can I have your "Acked-by" for this modification? I plan to push a
> "fixes" series though arm-soc git tree.

Yes, you can add it.

I tend not to respond to simple changes that are independent of the USB 
functionality, like this one.

Alan Stern

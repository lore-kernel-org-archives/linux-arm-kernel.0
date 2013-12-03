From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 3 Dec 2013 10:32:35 -0500 (EST)
Subject: [PATCH 3/3] usb: ohci-at91: use device managed clk retrieval
In-Reply-To: <529DE791.6080007@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1312031030390.1226-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Dec 2013, Nicolas Ferre wrote:

> On 03/12/2013 15:07, Boris BREZILLON :
> > Replace clk_get calls by devm_clk_get calls.
> >
> > Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> > Tested-by: Robert Nelson <robertcnelson@gmail.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Thanks Boris for these fixes.
> 
> Alan, Greg, can you take the whole series as fixes for 3.13?

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

The patches look fine to me.  But only the 1/3 patch fixes a bug; the 
others merely change the resource management.

Alan Stern

From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 4 Sep 2012 11:06:21 -0400 (EDT)
Subject: [PATCH 1/2] ARM: Kirkwood: ehci-orion: Add device tree binding
In-Reply-To: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
Message-ID: <Pine.LNX.4.44L0.1209041105460.1605-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 1 Sep 2012, Andrew Lunn wrote:

> Based on previous work by Michael Walle and Jason Cooper.
> 
> Made their work actually work, which required added interrupt from DT
> and auxdata, along with setting the dma_mask, which DT does not
> currently do.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

For the changes to ehci-orion.c:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

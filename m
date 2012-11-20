From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 20 Nov 2012 16:44:13 -0500 (EST)
Subject: [PATCH 159/493] usb: remove use of __devinit
In-Reply-To: <1353349642-3677-159-git-send-email-wfp5p@virginia.edu>
Message-ID: <Pine.LNX.4.44L0.1211201642540.1692-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>

For all the __devinit* annotations and all the EHCI, OHCI, and UHCI 
drivers:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

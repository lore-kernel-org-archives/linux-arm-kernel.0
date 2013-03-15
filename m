From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 15 Mar 2013 15:19:08 -0400 (EDT)
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <201303151700.27231.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Mar 2013, Arnd Bergmann wrote:

> On Friday 15 March 2013, Alan Stern wrote:
> > Roger just submitted my patch to split out ehci-omap.
> 
> Ok, if we can merge that for 3.9, the main issue will be resolved, because
> an OMAP+Orion config is much more interesting in practice than adding
> VT8500 to the mix.

I just got an automated message from Greg:

--------------------------------------------------------------------------
This is a note to let you know that I've just added the patch titled

    USB: EHCI: split ehci-omap out to a separate driver

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-next branch.
--------------------------------------------------------------------------

Unless something is changed, this patch won't get into 3.9-final.  
Do you want Greg to move it to his usb-linus branch?

Alan Stern

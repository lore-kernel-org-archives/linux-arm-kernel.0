From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 20:15:31 +0000
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
Message-ID: <201303152015.31292.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Alan Stern wrote:
> I just got an automated message from Greg:
> 
> --------------------------------------------------------------------------
> This is a note to let you know that I've just added the patch titled
> 
>     USB: EHCI: split ehci-omap out to a separate driver
> 
> to my usb git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> in the usb-next branch.
> --------------------------------------------------------------------------
> 
> Unless something is changed, this patch won't get into 3.9-final.  
> Do you want Greg to move it to his usb-linus branch?

I don't care much which way we do it, but I'd certainly like to
see one of these two solutions for the bug:

a) Apply Roger's patch for 3.9, and add my "USB: EHCI: DT support
   for generic bus glue" patch on top after it has been tested
b) Apply my "USB: EHCI: hot-fix OMAP and Orion multiplatform config"
   when I send a version based on the proper tree for 3.9, and leave
   the other ones to do it properly for 3.10.

	Arnd

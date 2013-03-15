From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 21:13:52 +0000
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <20130315192506.GA26618@kroah.com>
References: <201303151700.27231.arnd@arndb.de>
 <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
 <20130315192506.GA26618@kroah.com>
Message-ID: <201303152113.52258.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Greg Kroah-Hartman wrote:
> > Unless something is changed, this patch won't get into 3.9-final.  
> > Do you want Greg to move it to his usb-linus branch?
> 
> It's a bit too "big" for 3.9-final, sorry.

Would you consider the hot fix at the start of this thread for 3.9
then? I can resubmit it as a patch for inclusion with the missing
hunk added in if there are no objections.

	Arnd

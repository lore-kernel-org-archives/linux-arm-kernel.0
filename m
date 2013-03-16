From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 15 Mar 2013 17:09:36 -0700
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <201303152113.52258.arnd@arndb.de>
References: <201303151700.27231.arnd@arndb.de>
 <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
 <20130315192506.GA26618@kroah.com>
 <201303152113.52258.arnd@arndb.de>
Message-ID: <20130316000936.GB10166@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 09:13:52PM +0000, Arnd Bergmann wrote:
> On Friday 15 March 2013, Greg Kroah-Hartman wrote:
> > > Unless something is changed, this patch won't get into 3.9-final.  
> > > Do you want Greg to move it to his usb-linus branch?
> > 
> > It's a bit too "big" for 3.9-final, sorry.
> 
> Would you consider the hot fix at the start of this thread for 3.9
> then? I can resubmit it as a patch for inclusion with the missing
> hunk added in if there are no objections.

Feel free to resend, but remember, I am _very_ leery of pushing this
type of patch in at the moment, given my past history with it...

greg k-h

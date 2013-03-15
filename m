From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 15 Mar 2013 12:25:06 -0700
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
References: <201303151700.27231.arnd@arndb.de>
 <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
Message-ID: <20130315192506.GA26618@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 03:19:08PM -0400, Alan Stern wrote:
> On Fri, 15 Mar 2013, Arnd Bergmann wrote:
> 
> > On Friday 15 March 2013, Alan Stern wrote:
> > > Roger just submitted my patch to split out ehci-omap.
> > 
> > Ok, if we can merge that for 3.9, the main issue will be resolved, because
> > an OMAP+Orion config is much more interesting in practice than adding
> > VT8500 to the mix.
> 
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

It's a bit too "big" for 3.9-final, sorry.

greg k-h

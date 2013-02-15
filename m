From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 15 Feb 2013 10:07:50 -0800
Subject: [V2 0/8] usb: ehci: more bus glues as separate modules
In-Reply-To: <201302151610.52523.arnd@arndb.de>
References: <1360923853-7875-1-git-send-email-manjunath.goudar@linaro.org>
 <201302151610.52523.arnd@arndb.de>
Message-ID: <20130215180750.GA4525@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 04:10:52PM +0000, Arnd Bergmann wrote:
> On Friday 15 February 2013, Manjunath Goudar wrote:
> > Separate the SOC On-Chip host controller driver from ehci-hcd
> > host code into its own driver module
> > 
> > V2:
> > Modified the patches, based on the first version review comments  
> > 
> 
> The series looks good to me now, great work!
> 
> Please add my 'Acked-by: Arnd Bergmann <arnd@arndb.de>' for each patch.
> 
> Alan, Greg: I realize that it's too late to take the entire series for
> 3.9, but with the move of more ARM platforms to CONFIG_ARCH_MULTIPLATFORM,
> it is now possible to enable OMAP, VT8500 and ORION concurrently, along
> with the ones that are already moved out.
> 
> You should have a patch for OMAP, but that has not made it into linux-next
> yet. It would be good to have at least two out the three I mentioned
> merged into 3.9, in order to keep allyesconfig building, and take the
> rest after the merge window, for integration into 3.10.

I have no idea what to do with _ANY_ of these patches as they are all
sent without proper changelog comments saying why they are needed, come
in random series without proper ordering, get sent multiple times in the
same series with no known differences between them, and probably other
issues that I just don't even know about.

So I can't take these this late in the development process, sorry, that
would be negligent of me.

Manjunath, please get this all working properly, as it is, I've deleted
all of your patches from my "to-apply" queue for all of the above
reasons.

greg k-h

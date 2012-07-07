From: richard.zhao@freescale.com (Richard Zhao)
Date: Sat, 7 Jul 2012 22:56:20 +0800
Subject: [PATCH v8 06/14] USB: Chipidea: rename struct ci13xxx variables
 from udc to ci
In-Reply-To: <20120706180721.GA8983@kroah.com>
References: <1340963342-28735-1-git-send-email-richard.zhao@freescale.com>
 <1340963342-28735-7-git-send-email-richard.zhao@freescale.com>
 <20120706180721.GA8983@kroah.com>
Message-ID: <20120707145619.GA29746@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 11:07:21AM -0700, Greg KH wrote:
> On Fri, Jun 29, 2012 at 05:48:54PM +0800, Richard Zhao wrote:
> > struct ci13xxx represent the controller, which may be device or host,
> > so name its variables as ci.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Reviewed-by: Marek Vasut <marex@denx.de>
> 
> This patch fails to apply (the 5/14 had some fuzz, but I fixed that by
> hand.
#5 is good. Thanks.
> )  Odds are it's due to Felipe's other changes now in my tree.
> Care to rediff this, and the rest of the series against the usb-next
> branch and resend them so that I can apply them?
I'll send out v9 REBASE.

Thanks
Richard
> 
> I've applied the first 5 in this series already, so you don't have to
> resend them.
> 
> thanks,
> 
> greg k-h
> 

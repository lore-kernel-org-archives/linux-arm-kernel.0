From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:13:54 +0200
Subject: [PATCH v3 10/30] USB: ehci-omap: Use PHY APIs to get the PHY
 device and put it out of suspend
In-Reply-To: <Pine.LNX.4.44L0.1301291026020.1507-100000@iolanthe.rowland.org>
References: <1359453032-20604-1-git-send-email-rogerq@ti.com>
 <Pine.LNX.4.44L0.1301291026020.1507-100000@iolanthe.rowland.org>
Message-ID: <20130205091354.GJ32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 10:30:05AM -0500, Alan Stern wrote:
> On Tue, 29 Jan 2013, Roger Quadros wrote:
> 
> > For each port that is in PHY mode we obtain a PHY device using the USB PHY
> > library and put it out of suspend.
> > 
> > It is up to platform code to associate the PHY to the controller's
> > port and it is upto the PHY driver to manage the PHY's resources.
> 
> s/upto/up to/
> 
> > Also remove wired spacing around declarations we come across.
> 
> s/wired/weird/ -- not that people care about misspellings in the 
> Changelog.  You don't have to resubmit the patch just to fix these two 
> items.
> 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/010fe60b/attachment-0001.sig>

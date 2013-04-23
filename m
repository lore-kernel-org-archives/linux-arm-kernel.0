From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Apr 2013 19:12:25 +0300
Subject: [PATCH] usb: phy: phy core cannot yet be a module
In-Reply-To: <201304231811.35692.arnd@arndb.de>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
 <1366732475-479886-2-git-send-email-arnd@arndb.de>
 <20130423160759.GF15177@arwen.pp.htv.fi>
 <201304231811.35692.arnd@arndb.de>
Message-ID: <20130423161225.GH15177@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 23, 2013 at 06:11:35PM +0200, Arnd Bergmann wrote:
> On Tuesday 23 April 2013, Felipe Balbi wrote:
> > looks like this is the only way, indeed. Do you need on the merge window
> > on can this wait until -rc1 ? I just sent a pull request to Greg with
> > urgent fixes for the merge window.
> > 
> > Greg, if you want to take this one as a patch, go for it:
> > 
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> It's not relevant for real-life scenarios, it's fine as long as this
> makes it into 3.10.

sure, I can take this on -rc1 then.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/4b0bef5f/attachment-0001.sig>

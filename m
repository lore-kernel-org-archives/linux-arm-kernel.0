From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Mar 2013 14:09:32 +0200
Subject: [PATCH v4 0/6] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <87wqsujrdm.fsf@ashishki-desk.ger.corp.intel.com>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
 <20121128025217.GC18593@nchen-desktop>
 <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
 <CAOMZO5ArDLKDLEzhYc7EP2CNQGcT=vO7ctbiEsjzsGs+EaT7Dw@mail.gmail.com>
 <20130325162931.GB22810@pengutronix.de>
 <87wqsujrdm.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130326120932.GQ11244@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 26, 2013 at 02:08:05PM +0200, Alexander Shishkin wrote:
> > http://git.pengutronix.de/git/mgr/linux.git v3.9/topic/usb-phy
> > 4414a59 Merge 'v3.9/topic/usb-phy' into usb-3.9
> > a806027 usb: otg: mxs-phy: remove clkgate/sftrst clearing
> > 026881b usb: otg: mxs-phy: Improve mxs phy initialization
> > ed42fa9 usb: mxs-phy: register phy at usb phy library
> > d2783aa usb: phy: remove NULL pointer check in usb_add_phy()
> 
> looks like Felipe's call, doesn't it? I also can't seem to find these in
> my inbox. If you want me to ack them, you should at least send them to
> me. :)
> 
> Felipe, btw, is also often not copied on chipidea-related phy patches
> that I see. And just in case, Cc'ing him on this thread.

if it's not in my tree yet, it needs to be rebased to my 'next' brach,
since PHY drivers have moved out of drivers/usb/otg/. Rebase and resend.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130326/95ca4e5b/attachment.sig>

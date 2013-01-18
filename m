From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jan 2013 13:47:32 +0200
Subject: [RFC PATCH 0/7] usb: musb: add driver for control module
In-Reply-To: <1358239378-10030-1-git-send-email-kishon@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
Message-ID: <20130118114731.GA4379@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 15, 2013 at 02:12:51PM +0530, Kishon Vijay Abraham I wrote:
> Added a new driver for the usb part of control module. This has an API
> to power on the USB2 phy and an API to write to the mailbox depending on
> whether MUSB has to act in host mode or in device mode.
> 
> Writing to control module registers for doing the above task which was
> previously done in omap glue and in omap-usb2 phy is removed.
> 
> Also added the dt data to get MUSB working in OMAP platforms.
> This series has patches for both drivers and ARCH folders, so If it has to
> be split I'll do it.
> 
> This series was developed on
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
> 
> Did basic enumeration testing in omap4 beagle, omap4 sdp and omap3 beagle.

can you resend without RFC tag so I can apply ?

Thank you

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/353d7494/attachment-0001.sig>

From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 22 Jun 2016 18:48:41 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
In-Reply-To: <20160621113215.GP22406@atomide.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <20160621112944.GV29844@pali> <20160621113215.GP22406@atomide.com>
Message-ID: <201606221848.41305@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 June 2016 13:32:16 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [160621 04:32]:
> > On Tuesday 21 June 2016 04:25:36 Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [160615 05:08]:
> > > > * Pali Roh?r <pali.rohar@gmail.com> [160615 04:52]:
> > > > > On Wednesday 15 June 2016 04:02:02 Tony Lindgren wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > * Pali Roh?r <pali.rohar@gmail.com> [160615 03:58]:
> > > > > > > Hi! I just quickly looked at N900 status matrix
> > > > > > > https://elinux.org/N900 and there is still one thing not
> > > > > > > finished in DT: It is slot-name for omap_hsmmc driver.
> > > > > > > So switch from legacy board code to DT is regression.
> > > > > > 
> > > > > > That's fixed with the following in v4.7-rc series:
> > > > > > 
> > > > > > db863d896681 ("mmc: omap_hsmmc: Check if MMC slot name is
> > > > > > passed in pdata") 10c1f7d32bf4 ("ARM: OMAP2+: n900 needs
> > > > > > MMC slot names for legacy user space")
> > > > > 
> > > > > Great! Sorry, but now wiki is not fully updated with last
> > > > > changes and I do not have in my mind what was
> > > > > finished/merged and what not. It is going hard for me to
> > > > > track everything.
> > > > 
> > > > OK well maybe take one more look and then ack if no more
> > > > issues.
> > > 
> > > Pali, any news on this?
> > 
> > I have not looked at this deeply yet. Please give me some more
> > time.
> 
> OK I'd like to apply this series by Monday if no issues to have
> enough time for it in Linux next. Does that sound OK to you?
> 
> Regards,
> 
> Tony

Ok, now I looked at it and tested current version from torvalds tree.

There is still missing fixed support for IR, but that is waiting in 
media tree queue for next merge window.

So after IR patches land in torvalds tree, I'm fine with dropping legacy 
board code for n900 and you can add my Acked-by.

Sorry that it look so long time, but Nokia N900 is omap3 device with 
most features & drivers.

I need to say that Nokia N900 support has good support in mainline 
kernel, probably the best from all mobile phones. It is almost feature 
complete, missing parts are: DSP, both cameras, bluetooth and RM radio.

So thanks everybody for this big improvement!

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/cd656435/attachment-0001.sig>

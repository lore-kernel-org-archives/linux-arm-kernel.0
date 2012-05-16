From: marex@denx.de (Marek Vasut)
Date: Wed, 16 May 2012 15:22:48 +0200
Subject: [PATCH v1 0/7] preliminary work for adding imx6q_sabrelite usb
 support
In-Reply-To: <20120516083414.GB22251@nchen-desktop>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <20120516003748.GE29393@b20223-02.ap.freescale.net>
 <20120516083414.GB22251@nchen-desktop>
Message-ID: <201205161522.49115.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> > > Yes, I'd prefer to.
> > 
> > Me too. I think we can start with review each other's patch.
> > 
> > > Richard, are these 7 patches the only stuff that I have to apply on top
> > > of linux-usb/usb-next to get this working?
> > 
> > Yes.
> 
> Hi Marek and Richard,
> 
> The i.mx28 and i.mx6q use the same USB controller and USB PHY,
> Your patchset can be totally the same, only different is platform
> part. Below are my commnets for your patchset:
> - Use drivers/usb/otg/mxs-phy.c as PHY's driver.
> - Use drivers/usb/chipidea/ci13xxx_imx.c as controller's driver,
> all freescale usb uses the same controller.
> - Use DT for platform support, phandle can work around current
> multi-phy support problem.
> 
> My proposal how you work together (already discussed with richard)
> - Richard picks marek's controller's patch, and add DT support for
> i.mx28, send marek, me, shawn privately.
> - Marek tunes this DT patched patchset at i.mx28 platform,
> and add Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

You mean SoB by me, dont you ? ;-)

> for patchset, and send to mail list for review
> - Richard tests it and give some comments if there is any problems
> at i.mx6q.
> - Marek re-sends this patchset to mail list for review
> 
> Marek, if you agree with it, please take the responsibilities of the
> owner with this patchset, and be active during this patchset review
> procedure.

Fine with me, where can I get DT-enabled MXS kernel tree please?

Best regards,
Marek Vasut

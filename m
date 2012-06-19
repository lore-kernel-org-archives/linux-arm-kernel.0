From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 19 Jun 2012 01:14:58 +0000
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <CAOMZO5DF+CH+qe+VKc4vefkj05aXOtn0nVZK9vx+0kakP_em1A@mail.gmail.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <CAOMZO5BXsPtwC2CTt6Z-DjZUYhrWMKDkr2QnFoAKb-aLc1XsNA@mail.gmail.com>
 <201206181913.06886.marex@denx.de>
 <CAOMZO5DF+CH+qe+VKc4vefkj05aXOtn0nVZK9vx+0kakP_em1A@mail.gmail.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BE2DE2@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> > Do you have root TT enabled? If the pendrive isn't detected at all,
> it's
> 
> USB_EHCI_ROOT_HUB_TT is enabled.
> 
> > probably the PHY not enabling (disabling?) the discon detector upon
> init. But
> > the PHY driver is from my code, so that should work. Do you see any
> response at
> > all upon connecting the stick?
> 
> Nothing shows up in the console after connecting the stick.
> 
> Attached my .config file.
> 
Make sure the vbus is on for your usb port.

> Thanks,
> 
> Fabio Estevam

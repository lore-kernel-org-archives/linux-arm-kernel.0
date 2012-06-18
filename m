From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2012 14:25:20 -0300
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <201206181913.06886.marex@denx.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <CAOMZO5BXsPtwC2CTt6Z-DjZUYhrWMKDkr2QnFoAKb-aLc1XsNA@mail.gmail.com>
 <201206181913.06886.marex@denx.de>
Message-ID: <CAOMZO5DF+CH+qe+VKc4vefkj05aXOtn0nVZK9vx+0kakP_em1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 2:13 PM, Marek Vasut <marex@denx.de> wrote:

> Do you have root TT enabled? If the pendrive isn't detected at all, it's

USB_EHCI_ROOT_HUB_TT is enabled.

> probably the PHY not enabling (disabling?) the discon detector upon init. But
> the PHY driver is from my code, so that should work. Do you see any response at
> all upon connecting the stick?

Nothing shows up in the console after connecting the stick.

Attached my .config file.

Thanks,

Fabio Estevam
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config_usb
Type: application/octet-stream
Size: 45496 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120618/f378b5b1/attachment-0001.obj>

From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Dec 2012 20:45:22 +0100
Subject: [PATCH 2/2] mxc: enable EHCI PER clock
In-Reply-To: <CAOMZO5DzoCsVZY-2Zzoxd0ACGKaryzoMtg8qPm+ttriNQvR9Rg@mail.gmail.com>
References: <1355941777-99352-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1355941777-99352-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <CAOMZO5DzoCsVZY-2Zzoxd0ACGKaryzoMtg8qPm+ttriNQvR9Rg@mail.gmail.com>
Message-ID: <201212192045.22359.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Wed, Dec 19, 2012 at 4:29 PM, Gwenhael Goavec-Merou
> 
> <gwenhael.goavec-merou@armadeus.com> wrote:
> > EHCI PER clock (aka usb_div) must be enabled to have EHCI driver working.
> > 
> > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> 
> Have you considered to use the chipidea usb driver in mx27 instead?
> mx28/mx6 are already converted to the chipidea usb driver.

True, we should kill ehci-mxc ASAP. On the other hand, I'm not opposed to 
applying these, just bear in mind the driver might just disappear.

Best regards,
Marek Vasut

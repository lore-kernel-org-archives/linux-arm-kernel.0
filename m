From: marex@denx.de (Marek Vasut)
Date: Thu, 25 Jul 2013 05:57:44 +0200
Subject: Enabling USBH1 on mx53qsb
In-Reply-To: <CAOMZO5DYztMXpF33TLfGkvk3+SUa2_6oPNhupaAx6kxYwavStA@mail.gmail.com>
References: <CAOMZO5CAdxzn-3Xc2DZDYEXwsEznRrcqPbCbTDc5ieBkQkA8=g@mail.gmail.com>
 <20130725033716.GB4489@nchen-desktop>
 <CAOMZO5DYztMXpF33TLfGkvk3+SUa2_6oPNhupaAx6kxYwavStA@mail.gmail.com>
Message-ID: <201307250557.44651.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Thu, Jul 25, 2013 at 12:37 AM, Peter Chen <peter.chen@freescale.com> wrote:
> > seems u-boot already support mx53.
> > 
> > Can you measure the host 1 vbus pin? The vbus should be 5v to let
> > the host works normal.
> 
> The VBUS is the same for both USBH1 port and OTG ports and it is at
> 5V, since OTG port does work.

Check either VBUS or clock, it's one of those ;-)

Best regards,
Marek Vasut

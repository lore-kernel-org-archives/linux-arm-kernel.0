From: marex@denx.de (Marek Vasut)
Date: Thu, 27 Dec 2012 09:31:11 +0100
Subject: [PATCH v4 3/7] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <20121227082007.GA29123@nchen-desktop>
References: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
 <201212270821.55253.marex@denx.de> <20121227082007.GA29123@nchen-desktop>
Message-ID: <201212270931.12026.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> On Thu, Dec 27, 2012 at 08:21:55AM +0100, Marek Vasut wrote:
> > Dear Peter Chen,
> > 
> > [...]
> > 
> > > +
> > > +#define CI_VBUS_STABLE_TIMEOUT 500
> > 
> > Shall we not change this to static const int instead ?
> 
> Is it a must?
> I find the similar at drivers/usb/core/hub.c
[...]

No it's not. I was just pondering now that it's a local constant, it might just 
be like that.

Best regards,
Marek Vasut

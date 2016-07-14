From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 14 Jul 2016 14:04:14 -0300
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <20160713062521.GZ16643@pengutronix.de>
References: <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
 <CAOMZO5A=6HLPacwp0seBn_s+AVF7zaUjUO8wOb1WoyvU1JrH7A@mail.gmail.com>
 <20160711073721.GM16643@pengutronix.de>
 <CAOMZO5ASsA88TQLAPdyit0xr3Lqh8e+8C_ZgoUa7w2rZxTb-ag@mail.gmail.com>
 <20160712073859.GQ16643@pengutronix.de>
 <CAOMZO5B+grtejgSMKrZMT9inEdh+bL0smZKE52qtcQD1NCHrqQ@mail.gmail.com>
 <CAOMZO5D2E_G4ySUnj=yadziSunwMBSVZs-Rw=EvNybFKs2iD3w@mail.gmail.com>
 <20160712191541.GY16643@pengutronix.de>
 <CAOMZO5C3eQFfs=ZS5nfDw6XnEAgfcc_+W2n0y8Xd-zsTfd-+gA@mail.gmail.com>
 <CAOMZO5B4CUr_-U3s+fo-O_BcREWQijffXFeRmUPiwDWdhY07pQ@mail.gmail.com>
 <20160713062521.GZ16643@pengutronix.de>
Message-ID: <CAOMZO5BtP29PD-vf1WKG0yd7OJy9A0Sthn4EQ+CuF1As2cmKoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Jul 13, 2016 at 3:25 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> Which U-Boot did you test? Mainline or the vendor variant?
>
> Can you provide the output of
>
>         md 0x43fac000+0x584

Here it goes:
=> md.l 0x43fac584 1
43fac584: 00000000                               ....

>
> in U-Boot (which for sure has a different syntax that I don't know) and
> from Linux
>
>         memtool md 0x43fac000+0x584

The memtool utility version I have is broken for mx25, so I can't dump
this register easily in Linux.

Regards,

Fabio Estevam

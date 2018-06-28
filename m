From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 28 Jun 2018 10:54:58 +0800
Subject: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
In-Reply-To: <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
References: <cover.1530004712.git.sean.wang@mediatek.com>
 <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
 <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
Message-ID: <1530154498.29697.37.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-06-27 at 19:59 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> 
> > +config BT_HCIBTUART_MTK
> > +       tristate "MediaTek HCI UART driver"
> > +       depends on BT_HCIBTUART
> 
> > +       default y
> 
> Perhaps it's an overkill for users which would like to have less
> amount on stuff in kernel.

sure, the default y will be removed

> 
> > +#include <asm/unaligned.h>
> > +#include <linux/atomic.h>
> > +#include <linux/clk.h>
> > +#include <linux/firmware.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/serdev.h>
> 

[ ... ]

> >  MODULE_DEVICE_TABLE(of, btuart_of_match_table);
> > --
> > 2.7.4
> >
> 
> 
> 

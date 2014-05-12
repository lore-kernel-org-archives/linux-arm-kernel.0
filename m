From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 12 May 2014 10:25:12 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzNdIEFSTTogaS5NWDEgY2xrOiBBZGQgZGV2aWNldHJl?=
 =?UTF-8?B?ZSBzdXBwb3J0?=
In-Reply-To: <20140512051308.GZ5858@pengutronix.de>
References: <1399629542-32387-1-git-send-email-shc_work@mail.ru>
 <1399629542-32387-2-git-send-email-shc_work@mail.ru>
 <20140512051308.GZ5858@pengutronix.de>
Message-ID: <1399875912.608198589@f30.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 12 May 2014 07:13:08 +0200 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> On Fri, May 09, 2014 at 01:59:01PM +0400, Alexander Shiyan wrote:
> > This patch adds devicetree support CCM module for i.MX1 (MC9328MX1) CPUs.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  .../devicetree/bindings/clock/imx1-clock.txt       | 46 ++++++++++++++++++++++
> >  arch/arm/mach-imx/clk-imx1.c                       | 10 ++++-
> >  2 files changed, 55 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/imx1-clock.txt b/Documentation/devicetree/bindings/clock/imx1-clock.txt
> > new file mode 100644
> > index 0000000..f66fe37
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/imx1-clock.txt
> 
> Can we meld this for i.MX1 into this patch?:
> 
> commit 490dd8808a8baa093ac3b2bfc2f66f798599bb2c
> Author: Lucas Stach <l.stach@pengutronix.de>
> Date:   Thu Nov 14 11:18:57 2013 +0100
> 
>     ARM: imx5: introduce DT includes for clock provider
>     
>     Use clock defines in order to make devicetrees more
>     human readable.

Yes, I will prepare another series with the bindings. In any case I would
like to update this patch series.

---

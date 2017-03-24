From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 24 Mar 2017 09:28:36 +0800
Subject: [PATCH 05/15] ARM: dts: imx: fix PCI bus dtc warnings
In-Reply-To: <CAL_JsqKmbLP07zKN1SJAoe0xHjzjn80HQDRvqASXvhnUOBgAyA@mail.gmail.com>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-5-robh@kernel.org>
 <20170322081942.GM3443@dragon>
 <CAL_JsqKmbLP07zKN1SJAoe0xHjzjn80HQDRvqASXvhnUOBgAyA@mail.gmail.com>
Message-ID: <20170324012831.GB30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Tim who is the owner of Gateworks Ventana boards.

On Wed, Mar 22, 2017 at 08:53:34AM -0500, Rob Herring wrote:
> On Wed, Mar 22, 2017 at 3:19 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Tue, Mar 21, 2017 at 09:03:03PM -0500, Rob Herring wrote:
> >> dtc recently added PCI bus checks. Fix these warnings.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Shawn Guo <shawnguo@kernel.org>
> >> Cc: Sascha Hauer <kernel@pengutronix.de>
> >> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> >
> > Applied with a couple of changes below.
> 
> Thanks. BTW, forget to mention there's still one i.MX warning I did
> not fix. It's with the "sky2 at 8" PCI device node. The unit address is
> completely wrong. The comment says bus #8 which doesn't seem right
> either. The unit address should be "<device num>[,<function]". There
> should be a reg property which also has the bus number.

@Tim, these DTC warnings come from Ventana boards.  Can you take care of
them?

Shawn

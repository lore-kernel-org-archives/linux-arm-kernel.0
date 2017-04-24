From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 24 Apr 2017 16:45:15 +0200
Subject: [PATCH v2] arm: imx6: zii: Add i210 PCIe interface to the
 device tree
In-Reply-To: <20170424141012.GA12780@lunn.ch>
References: <1492321507-7174-1-git-send-email-cphealy@gmail.com>
 <1493023642.2891.2.camel@pengutronix.de> <20170424141012.GA12780@lunn.ch>
Message-ID: <1493045115.2891.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Am Montag, den 24.04.2017, 16:10 +0200 schrieb Andrew Lunn:
> On Mon, Apr 24, 2017 at 10:47:22AM +0200, Lucas Stach wrote:
> > Am Samstag, den 15.04.2017, 22:45 -0700 schrieb Chris Healy:
> > > The board has an Intel i210 Ethernet controller on its PCIe bus. Add a
> > > device tree node for this.
> > 
> > I wold prefer a better description on why we need this node, as PCIe is
> > an enumerable bus. Do you need this node to attach a MAC address or
> > something?
> 
> Hi Lucas
> 
> We need to attach an Ethernet switch, using the DSA binding. Please
> take a look at Documentation/binding/net/dsa.txt. We need a phandle to
> the i210 Ethernet MAC.

Sure, this rationale seems fine. Please make sure to include it in the
patch description on the next submission.

Regards,
Lucas

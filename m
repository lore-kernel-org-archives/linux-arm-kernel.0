From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 1 Nov 2016 22:17:08 +0800
Subject: [PATCH 3/5] ARM: dts: imx6qdl-sabrelite: add missing USB PHY
 reset control
In-Reply-To: <CAAMH-yu1oC8qaAtVwSxJxKxSmXMzMJkUeu4cUu3OB2yhDV8GBg@mail.gmail.com>
References: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
 <20161025211955.5345-4-gary.bisson@boundarydevices.com>
 <CAOMZO5Aok5w=Di0hZpr7E6PZr6rJ1Xg-xkWcB+u=7xKCT5uWvA@mail.gmail.com>
 <CAAMH-yu1oC8qaAtVwSxJxKxSmXMzMJkUeu4cUu3OB2yhDV8GBg@mail.gmail.com>
Message-ID: <20161101141707.GD9807@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 11:53:40PM +0200, Gary Bisson wrote:
> Hi Fabio,
> 
> On Tue, Oct 25, 2016 at 11:28 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi Gary,
> >
> > On Tue, Oct 25, 2016 at 7:19 PM, Gary Bisson
> > <gary.bisson@boundarydevices.com> wrote:
> >> Declared as a regulator since the driver doesn't have a reset-gpios
> >> property for this.
> >
> > Peter Chen is working on adding USB reset-gpio property this. Please
> > check his series:
> > https://www.spinics.net/lists/arm-kernel/msg536105.html
> 
> Thanks, I wasn't aware of this series. Indeed if this power sequence
> code gets upstream soon I guess we can drop both patches about the USB
> PHY reset.

Let's wait then instead of adding something that will be removed later.

Shawn

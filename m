From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Oct 2016 19:28:27 -0200
Subject: [PATCH 3/5] ARM: dts: imx6qdl-sabrelite: add missing USB PHY
 reset control
In-Reply-To: <20161025211955.5345-4-gary.bisson@boundarydevices.com>
References: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
 <20161025211955.5345-4-gary.bisson@boundarydevices.com>
Message-ID: <CAOMZO5Aok5w=Di0hZpr7E6PZr6rJ1Xg-xkWcB+u=7xKCT5uWvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

On Tue, Oct 25, 2016 at 7:19 PM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> Declared as a regulator since the driver doesn't have a reset-gpios
> property for this.

Peter Chen is working on adding USB reset-gpio property this. Please
check his series:
https://www.spinics.net/lists/arm-kernel/msg536105.html

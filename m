From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 25 Oct 2016 23:53:40 +0200
Subject: [PATCH 3/5] ARM: dts: imx6qdl-sabrelite: add missing USB PHY
 reset control
In-Reply-To: <CAOMZO5Aok5w=Di0hZpr7E6PZr6rJ1Xg-xkWcB+u=7xKCT5uWvA@mail.gmail.com>
References: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
 <20161025211955.5345-4-gary.bisson@boundarydevices.com>
 <CAOMZO5Aok5w=Di0hZpr7E6PZr6rJ1Xg-xkWcB+u=7xKCT5uWvA@mail.gmail.com>
Message-ID: <CAAMH-yu1oC8qaAtVwSxJxKxSmXMzMJkUeu4cUu3OB2yhDV8GBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Oct 25, 2016 at 11:28 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Gary,
>
> On Tue, Oct 25, 2016 at 7:19 PM, Gary Bisson
> <gary.bisson@boundarydevices.com> wrote:
>> Declared as a regulator since the driver doesn't have a reset-gpios
>> property for this.
>
> Peter Chen is working on adding USB reset-gpio property this. Please
> check his series:
> https://www.spinics.net/lists/arm-kernel/msg536105.html

Thanks, I wasn't aware of this series. Indeed if this power sequence
code gets upstream soon I guess we can drop both patches about the USB
PHY reset.

Note that our Nitrogen6_MAX is using the regulator approach, it will
need to be updated once Peter's series gets merged.

Regards,
Gary

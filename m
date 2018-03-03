From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 3 Mar 2018 09:38:28 -0300
Subject: [PATCH] ARM: dts: tpc: Device tree description of the TPC board
In-Reply-To: <20180303080604.6fe8a9d3@jawa>
References: <20180302121750.12865-1-lukma@denx.de>
 <CAOMZO5BTnfHRkGnROh3LJoGVPcBcQk=rroYip4V1DDBUbkRuKw@mail.gmail.com>
 <20180303080604.6fe8a9d3@jawa>
Message-ID: <CAOMZO5CL7kiiw-y2Tdt7C+G1T2GxFRR3bJKQi_mzWeMSNugutQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Sat, Mar 3, 2018 at 4:06 AM, Lukasz Majewski <lukma@denx.de> wrote:

> Previously (for other imx6q board) I've added entry to e.g.
> panel-simple.c file [1] to describe the display.
>
> I thought that adding timings to DTS is more welcome - hence we do not
> need to add any extra code to Linux when porting new board?

Adding an entry to panel-simple helps when people want to use this
panel into their dts, as they need only to pass a compatible string
line instead of passing all the LCD timings.

> The other upstreamed imx6q board used dual license - GPLv2 or X11
> (which is also called MIT license).
>
> I suppose that this license header shall be replaced with:
>
> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> Am I correct?

Yes, correct.

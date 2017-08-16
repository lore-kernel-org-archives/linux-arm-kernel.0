From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:43:18 +0200
Subject: [GIT PULL 3/3] Allwinner dts64 changes for 4.14
In-Reply-To: <20170807034307.5gw5ircl6eexsbfq@wens.csie.org>
References: <20170807031910.66qj742m3egmdex5@wens.csie.org>
 <20170807034307.5gw5ircl6eexsbfq@wens.csie.org>
Message-ID: <CAK8P3a0CQCSKwD6mAitby5BGArqpx7vAFH_80gcy+n85g7=JbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 5:43 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi Arnd, Olof,
>
> We still have a couple of dts64 patches in our tree that are not
> included in this pull request. These add missing aliases for the
> Ethernet controllers we enabled in 4.13-rc1. So we are aiming to
> rework them as fixes for 4.13. Otherwise this is just a fairly
> routine set of patches enabling the PMIC.

Ok.

> Allwinner arm64 DT changes for 4.14
>
> The usual improvement patches:
>
>   - R_INTC interrupt controller enabled for the A64 SoC
>
>   - AXP803 PMIC added and enabled on the Pine64 and SoPine boards

Pulled into next/dt64, thanks!

       Arnd

From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 28 Nov 2016 16:40:49 +0800
Subject: [PATCH net-next 0/5] Support Armada 37xx SoC (ARMv8 64-bits) in
 mvneta driver
In-Reply-To: <cover.2b146800967005632cd02d4da77397e6e2fdf51f.1480087510.git-series.gregory.clement@free-electrons.com>
References: <cover.2b146800967005632cd02d4da77397e6e2fdf51f.1480087510.git-series.gregory.clement@free-electrons.com>
Message-ID: <20161128164049.77137347@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Fri, 25 Nov 2016 16:30:13 +0100 Gregory CLEMENT wrote:

> Hi,
> 
> The Armada 37xx is a new ARMv8 SoC from Marvell using same network
> controller as the older Armada 370/38x/XP SoCs. This series adapts the
> driver in order to be able to use it on this new SoC. The main changes
> are:
> 
> - 64-bits support: the first patches allow using the driver on a 64-bit
>   architecture.
> 
> - MBUS support: the mbus configuration is different on Armada 37xx
>   from the older SoCs.
> 
> - per cpu interrupt: Armada 37xx do not support per cpu interrupt for
>   the NETA IP, the non-per-CPU behavior was added back.
> 
> The first item is solved by patches 1 to 3.
> The 2 last items are solved by patch 4.
> In patch 5 the dt support is added.
> 
> Beside Armada 37xx, the series have been tested on Armada XP and
> Armada 38x (with Hardware Buffer Management and with Software Buffer
> Managment).

AFAICT, this is a V2? seems no Change log ;)

Thanks,
Jisheng

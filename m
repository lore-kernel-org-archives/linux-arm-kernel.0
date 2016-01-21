From: davem@davemloft.net (David Miller)
Date: Thu, 21 Jan 2016 12:05:32 -0800 (PST)
Subject: [PATCH v3 0/4] net: mvneta: support more than one clk
In-Reply-To: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
References: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160121.120532.2109574129268460718.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Wed, 20 Jan 2016 19:27:21 +0800

> Some platforms may provide more than one clk for the mvneta IP, for
> example Marvell BG4CT provides "core" clk for the mac core, and "axi"
> clk for the AXI bus logic.
> 
> This series tries to addess the "more than one clk" issue. Note: to
> support BG4CT, we have lots of refactor work to do, eg. BG4CT doesn't
> have mbus concept etc.
> 
> Since v2:
>  - Name the optional clock as "bus", which is a bit more flexible.
> 
> Since v1:
>  - Add Thomas Acks to patch1 and patch2.
>  - make sure the headers are really sorted (some headers are still
>    unsorted in v1).
>  - disable axi clk before disabling core clk, Thank Thomas.
>  - update dt binding as Thomas suggested.

Series applied, thanks.

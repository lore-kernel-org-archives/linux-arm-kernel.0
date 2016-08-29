From: horms@verge.net.au (Simon Horman)
Date: Mon, 29 Aug 2016 11:02:46 +0200
Subject: [PATCH 0/3] Add R8A7792/Wheat board support
In-Reply-To: <3665116.9BjHTnhfR3@wasted.cogentembedded.com>
References: <3665116.9BjHTnhfR3@wasted.cogentembedded.com>
Message-ID: <20160829090245.GB12085@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 11:16:49PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20160826-v4.8-rc3' tag. We add the device tree support for
> the R8A7792-based Wheat board. I have only sparse board documentation
> at this point, according to which this board somewhat differs from the other
> R-Car evaluation boards in that it has debug serial port, debug Ethernet chip,
> and a NOR flash on the separate debug board (connected to the main board
> with a ribbon cable). I'm not sure how to approach this (DT overlay, perhaps?),
> for now I'm just posting the debug UART/Ethernet support the same way it was
> done for the Blanche board -- these components seem to be the same between 
> these 2 boards...
> 
> [1/3] DT: arm: shmobile: document Wheat board
> [2/3] ARM: dts: wheat: initial device tree
> [3/3] ARM: dts: wheat: add Ethernet support

Thanks, I have queued this up.

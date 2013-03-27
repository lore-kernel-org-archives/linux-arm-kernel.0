From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 19:47:53 +0900
Subject: [PATCH 2/3] ARM: shmobile: sh73a0: add irqpin DT nodes
In-Reply-To: <Pine.LNX.4.64.1303211704130.32438@axis700.grange>
References: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
 <Pine.LNX.4.64.1303211704130.32438@axis700.grange>
Message-ID: <20130327104753.GG3040@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:05:40PM +0100, Guennadi Liakhovetski wrote:
> Add DT nodes for the 4 irqpin interrupt controllers on sh73a0. We add them
> to sh73a0.dtsi, which is also used by configurations, doing all their
> device instantiation from board the .c code. We rely on the fact, that
> such configurations don't instantiate devices from the device-tree.

Thanks, queued up for v3.10 in the soc branch of the renesas tree.

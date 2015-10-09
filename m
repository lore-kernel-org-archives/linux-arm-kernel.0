From: horms@verge.net.au (Simon Horman)
Date: Fri, 9 Oct 2015 10:14:15 +0900
Subject: [PATCH] ARM: shmobile: porter: add VIN0/ADV7180 DT support
In-Reply-To: <2169211.txWv7mmrno@wasted.cogentembedded.com>
References: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
 <2169211.txWv7mmrno@wasted.cogentembedded.com>
Message-ID: <20151009011415.GC14231@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 12:45:49AM +0300, Sergei Shtylyov wrote:
> Define the  Porter board dependent part of the VIN0 device node.
> Add the device node for Analog Devices  ADV7180 video decoder to I2C2 bus.
> Add the necessary subnodes to interconnect VIN0 and ADV7180 devices.
> 
> This patch is  analogous to the commit 8d62f4f75320 ("ARM: shmobile:
> henninger: add VIN0/ADV7180 DT support") as there are no differences
> between the boards in this respect.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks Sergei,
										I have queued this one up for v4.4 too.

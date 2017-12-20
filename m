From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 14:07:30 +1030
Subject: [PATCH v3 00/19] ARM: dts: aspeed: updates and new machines
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <CACPK8Xdf3__yuMEvD0NiZXihU-8F1R15aEwwJueHLZ6Jfs82oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 1:53 PM, Joel Stanley <joel@jms.id.au> wrote:
> This series of device tree patches for the ASPEED BMC machines
> moves all systems to use the soon to be merged clk driver, and
> updates machines to use all of the drivers we have upstream.
>
>  v3: Address review from Rob and Cedric
>   - Move aspeed-gpio.h usage out into the patches where use of the GPIO
>     is added
>   - Clarify that the aspeed-clock.h patch will be merged as part of
>     the device tree tree. This is to ensure we don't depend on the clk
>     tree for building.

Arnd, Michael, Stephen; how do we resolve this? We need the
dt-bindings header to be present for both the clk driver and the
device tree to build.

The clk driver is not (yet - soon I hope?) merged by Michael and
Stephen. I am about to commit the device tree changes that will go
through the ARM SoC tree.

Cheers,

Joel

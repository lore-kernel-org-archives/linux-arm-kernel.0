From: joel@jms.id.au (Joel Stanley)
Date: Mon, 19 Feb 2018 18:14:52 +1030
Subject: [PATCH 0/6] ARM: dts: aspeed: Enable iBT and LPC, Palmetto fixes
In-Reply-To: <20180212074325.23436-1-joel@jms.id.au>
References: <20180212074325.23436-1-joel@jms.id.au>
Message-ID: <CACPK8XfSQrzXBDYOZKM5EpnRVsP+M92=UqMWvDwWSs67WdaHkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 6:13 PM, Joel Stanley <joel@jms.id.au> wrote:
> Hello,
>
> These changes enable recently (and not-so-recently) upstreamed drivers
> for the ASPEED BMC device trees.
>
> Palmetto also has some updates that bring it close to being able to boot
> a host with an upstream kernel.
>
> I will merge them through the ASPEED tree once they have been reviewed.
>
> Joel Stanley (6):
>   ARM: dts: aspeed: Add IPMI BT node
>   ARM: dts: aspeed: Enable IPMI BT node on OpenPower machines
>   ARM: dts: aspeed-g5: Update LPC node
>   ARM: dts: aspeed: Add LPC clock phandles
>   ARM: dts: palmetto: Add LEDs and GPIO keys
>   ARM: dts: aspeed: Add Palmetto GPIO hogs

Series merged to dt-for-4.17 in the aspeed tree. Thanks for the reviews Andrew.

Cheers,

Joel

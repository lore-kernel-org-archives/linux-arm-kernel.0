From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 3 Jan 2017 14:41:55 +0100
Subject: [PATCH 2/2] ARM: dts: imx6qdl-nitrogen6_som2: fix sgtl5000
 pinctrl init
In-Reply-To: <20170103112247.4563-3-gary.bisson@boundarydevices.com>
References: <20170103112247.4563-1-gary.bisson@boundarydevices.com>
 <20170103112247.4563-3-gary.bisson@boundarydevices.com>
Message-ID: <20170103134155.5mgn4ebq2afikwtm@t450s.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Jan 03, 2017 at 12:22:47PM +0100, Gary Bisson wrote:
> Since the codec is probed first, the pinctrl node should be
> under the codec node.
> 
> The codec init was working for this board since U-Boot was
> already setting GPIO_0 as CLKO1 but better fix it anyway.
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>

Fixes: 3faa1bb2e89c ("ARM: dts: imx: add Boundary Devices Nitrogen6_SOM2 support")

Thanks,
Gary

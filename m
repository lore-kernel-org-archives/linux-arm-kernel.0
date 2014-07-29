From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Jul 2014 17:22:37 +0800
Subject: [PATCH v2 0/7] vf610: Add USB support
In-Reply-To: <cover.1406558450.git.stefan@agner.ch>
References: <cover.1406558450.git.stefan@agner.ch>
Message-ID: <20140729092236.GH24750@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 04:57:26PM +0200, Stefan Agner wrote:
> Stefan Agner (7):
>   ARM: dts: vf610: Add USB PHY and controller
>   ARM: imx: clk-vf610: Add USBPHY clocks
...
>   ARM: dts: vf610: Add usbmisc for non-core registers
...
>   ARM: dts: vf610-colibri: Add USB support
>   ARM: dts: vf610-twr: Add USB support

These 'ARM: ...' patches look fine to me, and I will apply them on IMX
tree once the driver changes are accepted.

Shawn

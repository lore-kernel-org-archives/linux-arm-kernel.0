From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Jul 2014 14:11:20 +0800
Subject: [PATCH v3 0/4] ARM: vf610: add FlexCAN support
In-Reply-To: <cover.1405428166.git.stefan@agner.ch>
References: <cover.1405428166.git.stefan@agner.ch>
Message-ID: <20140716061118.GN2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 02:56:17PM +0200, Stefan Agner wrote:
> Stefan Agner (4):
>   ARM: dts: vf610: add FlexCAN node
>   ARM: imx: clk-vf610: fix FlexCAN clock gating

Applied these two, thanks.

>   can: flexcan: switch on clocks before accessing ecr register
>   can: flexcan: add vf610 support for FlexCAN

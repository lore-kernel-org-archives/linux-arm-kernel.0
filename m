From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 19 Nov 2018 00:02:51 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77965: Add CAN controller
 nodes
In-Reply-To: <20181118173327.4704-1-marek.vasut+renesas@gmail.com>
References: <20181118173327.4704-1-marek.vasut+renesas@gmail.com>
Message-ID: <20181118230250.GA2553@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 06:33:26PM +0100, Marek Vasut wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds CAN{0,1} controller nodes for the R8A77965 SoC.
> 
> Based on several similar patches of the R8A7795 device tree
> by Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> and Geert Uytterhoeven <geert+renesas@glider.be>.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org

Were you able to do some testing using EXIO connectors? Would be nice to
know what was tested.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/9ee64585/attachment.sig>

From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Mon, 11 Dec 2017 23:31:52 +0100
Subject: [v7, 3/3] ARM: dts: imx6qdl.dtsi/imx6ul.dtsi: add "fsl,
 imx6q-snvs-lpgpr" node
In-Reply-To: <20170620070932.10353-4-o.rempel@pengutronix.de>
References: <20170620070932.10353-4-o.rempel@pengutronix.de>
Message-ID: <cfd53377-437a-98d3-1a0e-1123495a35ee@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.06.2017 09:09, Oleksij Rempel wrote:
> This node is for Low Power General Purpose Register which can
> be used as Non-Volatile Storage.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
>  arch/arm/boot/dts/imx6ul.dtsi  | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index e426faa9c243..94e992558238 100644
(..)

FYI: It looks to me that while the driver itself from this series was
picked up and eventually reached Linus' tree this DT change was 
forgotten, since I can't find in any tree (or am I not looking at the
right place?).

Maciej

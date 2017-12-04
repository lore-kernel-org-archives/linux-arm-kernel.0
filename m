From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 4 Dec 2017 16:25:06 +0100
Subject: [PATCH v2 11/12] ARM: dts: imx6qdl-nitrogen6_max: Remove
 unneeded unit address
In-Reply-To: <1512390016-703-11-git-send-email-festevam@gmail.com>
References: <1512390016-703-1-git-send-email-festevam@gmail.com>
 <1512390016-703-11-git-send-email-festevam@gmail.com>
Message-ID: <20171204152506.cmcxtcuowz3hsarx@t450s.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Dec 04, 2017 at 10:20:15AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove the unneeded unit address for the i2cmux nodes in order to fix
> the following build warnings with W=1:
> 
> arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (unit_address_vs_reg): Node /i2cmux at 2 has a unit name, but no reg property
> arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (unit_address_vs_reg): Node /i2cmux at 3 has a unit name, but no reg property
> 
> While at it, rename the i2cmux nodes and subnodes to make it clearer to which
> i2c controller the mux belongs to.
> 
> Cc: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Gary Bisson <gary.bisson@boundarydevices.com>

Regards,
Gary

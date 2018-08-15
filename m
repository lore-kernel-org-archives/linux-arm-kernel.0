From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Aug 2018 14:24:55 -0600
Subject: [PATCH v4 3/6] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
In-Reply-To: <88a5997e37d048cfc2dabb44cc13dce89c93d5eb.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
 <88a5997e37d048cfc2dabb44cc13dce89c93d5eb.1534264292.git.leonard.crestez@nxp.com>
Message-ID: <20180815202455.GA15583@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2018 at 07:50:17PM +0300, Leonard Crestez wrote:
> This is required for the imx pci driver to send the PME_Turn_Off TLP.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/reset/reset-imx7.c             | 1 +

>  include/dt-bindings/reset/imx7-reset.h | 4 +++-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 4 insertions(+), 1 deletion(-)

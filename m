From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Sep 2017 18:30:33 -0500
Subject: [PATCH 1/5] irqchip/ls-scfg-msi: add LS1012a MSI support
In-Reply-To: <20170919092658.22482-2-Zhiqiang.Hou@nxp.com>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
 <20170919092658.22482-2-Zhiqiang.Hou@nxp.com>
Message-ID: <20170921233033.zy7xt7hdfxvhjg7o@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 05:26:54PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The ls1012a implement only 1 msi controller, and it is the same as
> ls1043a.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt         | 1 +
>  drivers/irqchip/irq-ls-scfg-msi.c                                        | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

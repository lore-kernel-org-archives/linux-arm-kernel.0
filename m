From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jan 2017 11:11:32 -0600
Subject: [PATCH 1/9] irqchip/ls-scfg-msi: fix typo of MSI compatible
 strings
In-Reply-To: <1482829985-24421-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1482829985-24421-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20170103171132.xz5jjeovzfohi2xk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 05:12:57PM +0800, Minghuan Lian wrote:
> The patch is to fix typo of the Layerscape SCFG MSI dts compatible
> strings. "1" is replaced by "l".
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt    | 6 +++---
>  drivers/irqchip/irq-ls-scfg-msi.c                                   | 6 ++++--
>  2 files changed, 7 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

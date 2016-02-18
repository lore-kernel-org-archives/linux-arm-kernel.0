From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Feb 2016 08:36:39 -0600
Subject: [PATCH v3] dts/ls2080a: Update PCIe compatible
In-Reply-To: <1455674663-9273-1-git-send-email-Mingkai.Hu@freescale.com>
References: <1455674663-9273-1-git-send-email-Mingkai.Hu@freescale.com>
Message-ID: <20160218143639.GK9654@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 10:04:23AM +0800, Mingkai Hu wrote:
> From: Minghuan Lian <minghuan.lian@nxp.com>
> 
> The patch adds LS2085a to PCIe compatible to fix the compatibility
> issue when using firmware with LS2085a compatible property.
> 
> Signed-off-by: Minghuan Lian <minghuan.lian@nxp.com>
> Signed-off-by: Mingkai Hu <mingkai.hu@nxp.com>
> ---
> v3:
>  - Make the compatible consistent between layerscape-pci.txt
>    and dts file.
> 
> v2:
>   - Rebased to latest kernel base
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt |  2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi           | 12 ++++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

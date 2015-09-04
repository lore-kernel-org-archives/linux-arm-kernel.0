From: pku.leo@gmail.com (Leo Li)
Date: Fri, 4 Sep 2015 12:56:39 -0500
Subject: [PATCH v2 04/10] doc/bindings: Update PCIe devicetree binding
 documentation for LS2080A
In-Reply-To: <1441349872-4560-5-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-5-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <CADRPPNRGpzWawsqLHCiv530HbtPf+9RaPzOtvy88ftwv2ffqLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2015 at 1:57 AM, Bhupesh Sharma
<bhupesh.sharma@freescale.com> wrote:
> Add the documentation for compatible string "fsl,ls2080a-pcie"
> for Freescale's LS2080A platform.
>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 6286f04..e72e68f 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>
>  Required properties:
> -- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie"
> +- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie",
> +  "fsl,ls2080a-pcie".

Make it generic like "fsl,<chip>-pcie"

- Leo

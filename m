From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 13 May 2018 22:15:18 -0300
Subject: [PATCH] ARM: dts: imx: add proper #address-cells/#size-cells for
 ipu_di port nodes
In-Reply-To: <1526260306-14063-1-git-send-email-shawnguo@kernel.org>
References: <1526260306-14063-1-git-send-email-shawnguo@kernel.org>
Message-ID: <CAOMZO5BKJSbX-u3bAKrskwSFzfaMP+TgoE-OZC53RjTHJLk1Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 10:11 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> It adds proper #address-cells/#size-cells for ipu_di port nodes to fix
> the following DTC warnings.
>
> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (reg_format): /soc/ipu at 2400000/port at 2/endpoint at 0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (avoid_default_addr_size): /soc/ipu at 2400000/port at 2/endpoint at 0: Relying on default #address-cells value
> ...
>
> Fixes: e6bb17850d1e ("ARM: dts: imx: fix IPU OF graph endpoint node names")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

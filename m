From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 17:29:59 -0500
Subject: [PATCH v6 2/3] Documentation: DT: net: Add Xilinx gmiitorgmii
 converter device tree binding documentation
In-Reply-To: <1470808208-32133-3-git-send-email-appanad@xilinx.com>
References: <1470808208-32133-1-git-send-email-appanad@xilinx.com>
 <1470808208-32133-3-git-send-email-appanad@xilinx.com>
Message-ID: <20160810222959.GA3764@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 11:20:07AM +0530, Kedareswara rao Appana wrote:
> Device-tree binding documentation for xilinx gmiitorgmii converter.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v6:
> ---> Removed mdio description as suggested by Florian.
> Changes for v5:
> ---> Fixed Indentation in the example as suggested by Michal.
> Changes for v4:
> --> Modified compatible as suggested by Rob.
> --> Removed underscores from the converter node name as suggested by Rob.
> Changes for v3:
> --> None.
> Changes for v2:
> --> New patch
> 
>  .../devicetree/bindings/net/xilinx_gmii2rgmii.txt  | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt

Acked-by: Rob Herring <robh@kernel.org>

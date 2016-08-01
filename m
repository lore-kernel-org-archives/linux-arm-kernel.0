From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Aug 2016 11:18:06 -0500
Subject: [PATCH v18 2/6] ARM: socfpga: add bindings document for fpga
 bridge drivers
In-Reply-To: <20160712193645.9098-3-atull@opensource.altera.com>
References: <20160712193645.9098-1-atull@opensource.altera.com>
 <20160712193645.9098-3-atull@opensource.altera.com>
Message-ID: <20160801161806.GA16067@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 02:36:41PM -0500, Alan Tull wrote:
> Add bindings documentation for Altera SOCFPGA bridges:
>  * fpga2sdram
>  * fpga2hps
>  * hps2fpga
>  * lwhps2fpga
> 
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> Signed-off-by: Matthew Gerlach <mgerlach@altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v2:  separate into 2 documents for the 2 drivers
> v12: bump version to line up with simple-fpga-bus version
>      remove Linux specific notes such as references to sysfs
>      move non-DT specific documentation elsewhere
>      remove bindings that would have been used to pass configuration
>      clean up formatting
> v13: Remove 'label' property
>      Change property from init-val to bridge-enable
>      Fix email address
> v14: Add resets
>      Change order of bridges to put lw bridge (controlling bridge) first
> v15: No change in this patch for v15 of this patch set
> v16: Added regs property, cleaned up unit addresses
> v17: No change to this patch in v17 of patch set
> v18: Changed to not need reset-names property
>      node names as fpga-bridge at ...
>      labels as fpga_bridge
>      Add address of fpgaportrst to give and address for f2s bridge
> ---
>  .../bindings/fpga/altera-fpga2sdram-bridge.txt     | 16 +++++++++
>  .../bindings/fpga/altera-hps2fpga-bridge.txt       | 39 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt

Acked-by: Rob Herring <robh@kernel.org>

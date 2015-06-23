From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 23 Jun 2015 11:05:14 -0700
Subject: [PATCHv5 1/2] dts: Adding docs for Xilinx LogiCORE IP mailbox
 driver.
In-Reply-To: <1435082402-29239-2-git-send-email-moritz.fischer@ettus.com>
References: <1435082402-29239-1-git-send-email-moritz.fischer@ettus.com>
 <1435082402-29239-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20150623180513.GE20178@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-06-23 at 11:00AM -0700, Moritz Fischer wrote:
> Changes from v4:
> - Changed mbox cells property from 1 to 0
> - Fixed interrupt property
> 
> Changes from v3:
> - Changed reg size to 0x100
> 
> Changes from v2:
> - Addressed Michal's stylistic comments
> - Fixed typo in compatible string
> 
> Changes from v1:
> - Added common clock framework support
> 
> Changes from v0:
> - Fixed example bindings
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  .../devicetree/bindings/mailbox/xilinx-mailbox.txt | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> new file mode 100644
> index 0000000..269c026
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> @@ -0,0 +1,44 @@
> +Xilinx Mailbox Driver
> +=====================
> +
> +Required properties:
> +- compatible       : "xlnx,mailbox-2.1".
> +- reg              :  physical base address of the mailbox and length of
> +                      memory mapped region.
> +- #mbox-cells      :  common mailbox binding property to identify the number
> +                      of cells required for the mailbox specifier, should be 1

I guess this should say "should be 0" now?

	S?ren

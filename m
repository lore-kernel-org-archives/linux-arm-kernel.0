From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 5 Nov 2012 15:54:10 -0600
Subject: [PATCH v3] ARM: zynq: Allow UART1 to be used as DEBUG_LL console.
In-Reply-To: <1352151949-18319-1-git-send-email-nbowler@elliptictech.com>
References: <1352151949-18319-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <20121105215410.GC1254@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 04:45:49PM -0500, Nick Bowler wrote:
> The main UART on the Xilinx ZC702 board is UART1, located at address
> e0001000.  Add a Kconfig option to select this device as the low-level
> debugging port.  This allows the really early boot printouts to reach
> the USB serial adaptor on this board.
>
> For consistency's sake, add a choice entry for UART0 even though it is
> the the default if UART1 is not selected.
>
> Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
> Tested-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
> Sorry all for the phenominal delay in sending this out.  Josh, I kept
> your Tested-By since this version is Obviously Equivalent??? to v2...

I re-tested again just in case and everything is good.

Thanks,
  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/c752664b/attachment-0001.sig>

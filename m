From: josh.cartwright@ni.com (Josh Cartwright)
Date: Tue, 20 Nov 2012 07:37:57 -0600
Subject: [PATCH] ARM: zynq: Remove all unused mach headers
In-Reply-To: <1353417817-15513-1-git-send-email-michal.simek@xilinx.com>
References: <1353417817-15513-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <20121120133757.GY1718@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 02:23:37PM +0100, Michal Simek wrote:
> Remove empty unused mach/hardware.h.
> mach/irqs.h is unused because SPARSE_IRQ are ON by default.
> mach/timex.h is unused because of CONFIG_ARCH_MULTIPLATFORM.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Tested-by: Josh Cartwright <josh.cartwright@ni.com>

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/aafc715a/attachment.sig>

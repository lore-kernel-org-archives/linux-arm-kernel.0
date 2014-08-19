From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 19 Aug 2014 22:37:27 +0530
Subject: [PATCH] dma: xilinx: Remove .owner field for driver
In-Reply-To: <f82330042cf6185a1f4e18232ebf6999662ae48f.1407931050.git.michal.simek@xilinx.com>
References: <f82330042cf6185a1f4e18232ebf6999662ae48f.1407931050.git.michal.simek@xilinx.com>
Message-ID: <20140819170727.GU13288@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 01:57:42PM +0200, Michal Simek wrote:
> There is no need to init .owner field.
> 
> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
> 
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."

Applied, thanks

-- 
~Vinod

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140819/6c31ff94/attachment.sig>

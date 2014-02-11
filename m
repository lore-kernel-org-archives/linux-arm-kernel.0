From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 11 Feb 2014 15:12:47 +0200
Subject: [PATCH] video: xilinxfb: Move xilinxfb_platform_data directly
 to the driver
In-Reply-To: <af8de8bd8803b319c0f6a02ca5109768e5ef8457.1392101292.git.michal.simek@xilinx.com>
References: <af8de8bd8803b319c0f6a02ca5109768e5ef8457.1392101292.git.michal.simek@xilinx.com>
Message-ID: <52FA21CF.1040809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/14 08:48, Michal Simek wrote:
> No reason to have separate file in header in include/linux folder
> if this is purely driver specific structure.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> I have this patch in my devel tree for a while and would like
> to hear your opinion. I can't see any reason to have
> xilinxfb_platform_data in header if this is purely OF driver
> used on OF archs.
> ---
>  drivers/video/xilinxfb.c | 15 ++++++++++++++-
>  include/linux/xilinxfb.h | 30 ------------------------------
>  2 files changed, 14 insertions(+), 31 deletions(-)
>  delete mode 100644 include/linux/xilinxfb.h

Thanks. Queued for 3.15.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/1077943e/attachment.sig>

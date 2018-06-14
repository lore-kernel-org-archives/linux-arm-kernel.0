From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 14 Jun 2018 13:45:20 -0700
Subject: [PATCH v8 03/10] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <1529000862-11510-4-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
 <1529000862-11510-4-git-send-email-jollys@xilinx.com>
Message-ID: <3044c2b9-2268-dfcb-2d45-0117c6f91a8d@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2018 11:27 AM, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add ZynqMP firmware IOCTL API to control and configure
> devices like PLLs, SD, Gem, etc.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  2 ++
>  2 files changed, 22 insertions(+)

Hi,

Does this driver claim (implement) some specific ioctl code or ID?

If so, its ioctl numbers should be documented in Documentation/ioctl/ioctl-number.txt.

thanks,
-- 
~Randy

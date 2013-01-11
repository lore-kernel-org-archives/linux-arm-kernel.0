From: balbi@ti.com (Felipe Balbi)
Date: Fri, 11 Jan 2013 12:56:51 +0200
Subject: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
In-Reply-To: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130111105651.GF11085@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 11, 2013 at 05:56:28PM +0800, Peter Chen wrote:
> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the SoC type, and updates the platform code accordingly.
> 
> Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> Tested at mx51 bbg board, it works ok after enable phy clock
> (Need another patch to fix this problem)
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

this is too big for -rc, can you break it down into smaller pieces ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/ae0495ad/attachment.sig>

From: balbi@ti.com (Felipe Balbi)
Date: Wed, 23 Jan 2013 13:24:22 +0200
Subject: [PATCH v2 2/4] ARM: OMAP: devices: create device for usb part of
 control module
In-Reply-To: <1358777308-2409-3-git-send-email-kishon@ti.com>
References: <1358777308-2409-1-git-send-email-kishon@ti.com>
 <1358777308-2409-3-git-send-email-kishon@ti.com>
Message-ID: <20130123112422.GF29258@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 21, 2013 at 07:38:26PM +0530, Kishon Vijay Abraham I wrote:
> A seperate driver has been added to handle the usb part of control
> module. A device for the above driver is created here, using the register
> address information to be used by the driver for powering on the PHY and
> for writing to the mailbox.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Tony ? Without this we won't have the control module driver.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/e5736514/attachment.sig>

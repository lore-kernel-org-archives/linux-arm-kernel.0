From: bleung@google.com (Benson Leung)
Date: Mon, 2 Jul 2018 16:13:18 -0700
Subject: [PATCH 0/3] platform/chrome: mfd: Move cros-ec transport drivers
 to drivers/platform
In-Reply-To: <20180702102201.13461-1-enric.balletbo@collabora.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
Message-ID: <20180702231318.GB86110@decatoncale.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

On Mon, Jul 02, 2018 at 12:21:58PM +0200, Enric Balletbo i Serra wrote:
> Hi,
> 
> The cros-ec transport drivers are placed in two subsystems, in MFD and
> in platform/chrome. As far as I know there is no reason for this, so,
> move the I2C and the SPI cros-ec transport driver from the MFD subsystem
> to the platform/chrome. The series also removes the MFD_ prefix for the
> Kconfig symbols, modifies the defconfigs that used these symbols and
> fixes the KEYBOARD_CROS_EC Kconfig help.
> 

Thanks for putting this together.

I can create an IB with this for the others to pull. What do you all think?

Thanks,
Benson

-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung at google.com
Chromium OS Project
bleung at chromium.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/20877326/attachment.sig>

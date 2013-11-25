From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 14:43:24 -0600
Subject: [PATCH 3/3] ARM: keystone: defconfig: enable USB host mode support
In-Reply-To: <1385410581-12148-4-git-send-email-w-kwok2@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-4-git-send-email-w-kwok2@ti.com>
Message-ID: <20131125204323.GK18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 25, 2013 at 03:16:21PM -0500, WingMan Kwok wrote:
> Enable the USB host mode support on TI's Keystone platform.
> It also enables the support of usb mass storage, FAT and Ext4
> filesystems to test rootfs mount over an USB disk.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>

no phy driver anywhere ? How will nop-xceiv ever probe if you don't
enable the driver for it ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/f58f7ddf/attachment-0001.sig>

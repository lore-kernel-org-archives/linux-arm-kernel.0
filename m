From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 13:55:04 +0200
Subject: [PATCH v3] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <20141003115048.GD1349@katana>
References: <1412334482-20720-1-git-send-email-anders.berg@avagotech.com>
 <20141003115048.GD1349@katana>
Message-ID: <20141003115504.GE1349@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 01:50:48PM +0200, Wolfram Sang wrote:
> On Fri, Oct 03, 2014 at 01:08:02PM +0200, Anders Berg wrote:
> > Add I2C bus driver for the controller found in the LSI Axxia family SoCs. The
> > driver implements 10-bit addressing and SMBus transfer modes via emulation
> > (including SMBus block data read).
> > 
> > Signed-off-by: Anders Berg <anders.berg@avagotech.com>
> 
> Applied to for-next, thanks!

You missed to move the Kconfig part to embedded. Fixed that for you!
Nonetheless, was a quite smooth driver submission, thanks.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/c1942e26/attachment.sig>

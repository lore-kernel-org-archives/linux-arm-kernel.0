From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Aug 2013 14:31:53 +0200
Subject: [PATCH 2/2] i2c: davinci: Allow i2c driver available for
 keystone platforms
In-Reply-To: <1374712099-32095-3-git-send-email-santosh.shilimkar@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
 <1374712099-32095-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130815123153.GD17155@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 08:28:19PM -0400, Santosh Shilimkar wrote:
> Keystone SOCs uses the same I2C IP as available on DaVinci SOCs.
> Update the config so that ARCH_KEYSTONE can use it.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/1dbdc002/attachment.sig>
